require 'pathname'

# assumes we're installing via :path or :git, not gems
ROOT   = Pathname.new(Hobo.root).realpath.parent
GITHUB = "/github/Hobo/hobodoc/edit/master"

require "#{Rails.root}/lib/api_doc_loader"

def process_body(md)
  ApiTagDef.linkify(Maruku.new(md).to_html) do |tag|
    "<a href='/tagdef/#{tag.taglib.plugin.name}/#{tag.taglib.name}/#{tag.tag}'>&lt;#{tag.tag}&gt;</a>"
  end
end

def make_edit_link(filename)
  Pathname.new(filename)
  Pathname.new(filename).realpath
  Pathname.new(filename).realpath.relative_path_from(ROOT)
  "#{GITHUB}/#{Pathname.new(filename).realpath.relative_path_from(ROOT)}"
end

namespace :cookbook do
  desc "Load the api by parsing the taglibs in the Hobo plugin"
  task :load_api_docs => :environment do
    ApiDocLoader.load
  end

  desc "Load the manual pages from markdown in hobo/doc/manual/* and autogenerate generator man pages"
  task :load_manual => :environment do
    slugs = {}
    generators = []
    File.read("#{ROOT}/doc/manual/slugs").split.each_with_index { |slug, pos|
      slugs[slug] = pos
      generators << slug.gsub('generators/', '') if slug.starts_with?("generators/")
    }
    Dir["#{ROOT}/doc/manual/*.markdown"].each do |f|
      body = File.read(f)
      title = body.split("\n").first.gsub(/^# /, '')
      slug = File.basename(f, '.markdown')
      puts "#{slugs[slug]}: #{slug}: #{title}"
      ms = ManualSection.find_or_create_by_slug(slug, :body => body, :title => title)
      ms.body = process_body(body)
      ms.title = title
      ms.position = slugs[slug]
      ms.edit_link = make_edit_link(f)
      ms.save!
    end
    Dir["#{ROOT}/doc/manual/*/*.markdown"].each do |f|
      body = File.read(f)
      title = body.split("\n").first.gsub(/^# /, '')
      section_slug = File.basename(File.dirname(f))
      section = ManualSection.find_by_slug(section_slug)
      slug = "#{section_slug}/#{File.basename(f, '.markdown')}"
      puts "#{slugs[slug]}: #{slug}: #{title}"
      ms = ManualSubsection.find_or_create_by_slug(slug, :body => body, :title => title)
      ms.body = process_body(body)
      ms.title = title
      ms.position = slugs[slug]
      ms.manual_section = section
      ms.edit_link = make_edit_link(f)
      ms.save!
    end
    section = ManualSection.find_by_slug('generators')
    generators.each do |gen|
      raw = `bundle exec rails g hobo:#{gen} --help`
      body = "Generators -- #{gen}\n{: .document-title}\n\n" +
        raw.gsub(/^  /,"    ").
        gsub(/^(\w(\w|\s)*):(.*)/) {|s| "\n## #{$1}\n\n    #{$3}\n"}.
        gsub("#{Rails.root}", ".")
      title = gen
      slug = "generators/#{gen}"
      puts "#{slugs[slug]}: #{slug}: #{title}"
      ms = ManualSubsection.find_or_create_by_slug(slug, :body => body, :title => title)
      ms.body = process_body(body)
      ms.title = title
      ms.position = slugs[slug]
      ms.manual_section = section
      ms.edit_link = "#{GITHUB}/hobo/lib/generators/hobo/#{gen}/#{gen}_generator.rb"
      ms.save!
    end
  end

  desc "Load the tutorial pages from markdown in hobo/doc/tutorials/*"
  task :load_tutorials => :environment do
    Dir["#{ROOT}/doc/tutorials/*.markdown"].each do |f|
      body = File.read(f)
      title = body.split("\n").first.gsub(/^# /, '')
      slug = File.basename(f, '.markdown')
      puts "#{slug}: #{title}"
      ms = Tutorial.find_or_create_by_slug(slug, :body => body, :title => title)
      ms.body = process_body(body)
      ms.title = title
      ms.edit_link = make_edit_link(f)
      ms.save!
    end
    Dir["#{Rails.root}/gitorials/*.markdown"].each do |f|
      body = File.read(f)
      title = body.split("\n").first.gsub(/^# /, '')
      slug = File.basename(f, '.markdown')
      puts "#{slug}: #{title}"
      ms = Tutorial.find_or_create_by_slug(slug, :body => body, :title => title)
      ms.body = process_body(body)
      ms.title = title
      ms.edit_link = nil
      ms.save!
    end
  end

  desc "Rebuild agility.markdown"
  task :rebuild_agility => :environment do
    Gitorial.new("#{Rails.root}/gitorials/agility", "http://github.com/Hobo/agility-gitorial/commit/", "/patches/agility").process.each do |filename, markdown|
      next if markdown==""
      f=open("#{Rails.root}/gitorials/#{filename}", "w")
      f.write(markdown)
      f.close
    end
  end

  desc "Rebuild generator documentation"
  task :rebuild_generator_docs => :environment do
    ManualController::SUBTITLES['generators'].each do |gen, title|
      raw = `bundle exec rails g hobo:#{gen} --help`
      out = "Generators -- #{title[1].gsub('_', '\_')}\n{: .document-title}\n\n" +
        raw.gsub(/^  /,"    ").
        gsub(/^(\w(\w|\s)*):(.*)/) {|s| "\n## #{$1}\n\n    #{$3}\n"}.
        gsub("#{Rails.root}", ".")
      Dir.mkdir("#{Rails.root}/manual/generators") rescue nil
      open("#{Rails.root}/manual/generators/#{gen}.markdown", "w") do |f|
        f.write(out)
      end
    end
  end

  desc "git pull all plugins/submodules (except for non-Hobo project)"
  task :pull_all => :environment do
    ['public/patches/agility'].each {|sub|
      sh "cd #{sub} && git fetch origin && git checkout origin/master"
    }
    sh "rm -rf gitorials/agility ; git submodule update gitorials/agility ; cd gitorials/agility && git checkout -f origin/master"
    sh " bundle update hobo_support hobo_fields dryml hobo hobo_rapid hobo_clean hobo_clean_admin hobo_jquery hobo_jquery hobo_jquery_ui hobo_tree_table select_one_or_new_dialog hobo_simple_color hobo_tokeninput hobo_data_tables hobo_bootstrap hobo_mapstraction hobo_clean_sidemenu hobo_omniauth --source hobo"
  end

  desc "do all update tasks"
  task :update => [:environment, :pull_all, :load_api_docs, :rebuild_agility, :load_tutorials, :load_manual] do
    true
  end
end


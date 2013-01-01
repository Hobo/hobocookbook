require 'nokogiri'
namespace :cookbook_transition do
  desc "Export the recipes"
  task :export_recipes => :environment do
    FileUtils.mkdir_p("#{Rails.root}/db/recipes")
    File.open("#{Rails.root}/db/recipes/recipes.markdown", "w") do |index|
      index.write("# User Contributed Recipes\n\n")
      Recipe.includes(:images, :comments, :questions, :user).order_by("id desc").each do |r|
        index.write("* [#{r.name.gsub('<', '`<').gsub('>', '>`')}](#{r.to_param}) by #{r.user.username} on #{q.created_at.to_date}\n")
        File.open("#{Rails.root}/db/recipes/#{r.to_param}.markdown", "w") do |f|
          f.write("# #{r.name.gsub('<', '`<').gsub('>', '>`')}\n\n")
          f.write("Originally written by #{r.user.username} on #{r.created_at.to_date}.\n\n")
          r.questions.each do |q|
            f.write("This recipe answers [#{q.subject}](/questions/#{q.to_param})\n\n")
          end
          f.write(r.body)
          f.write("\n\n")
          r.images.each do |i|
            f.write("![image](/images/#{i.image_file_name})\n\n")
          end
        end
      end
    end
  end

  desc "Export the questions"
  task :export_questions => :environment do
    FileUtils.mkdir_p("#{Rails.root}/db/questions")
    File.open("#{Rails.root}/db/questions/questions.markdown", "w") do |index|
      index.write("# User Questions\n\n")
      Question.includes(:recipes, :user).order_by("id desc").each do |q|
        index.write("* [#{q.subject.gsub('<', '`<').gsub('>', '>`')}](#{q.to_param}) by #{q.user.username} on #{q.created_at.to_date}\n")
        File.open("#{Rails.root}/db/questions/#{q.to_param}.markdown", "w") do |f|
          f.write("# #{q.subject.gsub('<', '`<').gsub('>', '>`')}\n\n")
          f.write("Originally written by #{q.user.username} on #{q.created_at.to_date}.\n\n")
          q.recipes.each do |r|
            f.write("This question answered by recipe: [#{r.name}](/tutorials/#{r.to_param})\n\n")
          end
          f.write(q.description)
        end
      end
    end
  end

  desc "Export the recipe comments"
  task :export_recipe_comments => :environment do
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.rss('version'=>"2.0",  'xmlns:content'=>"http://purl.org/rss/1.0/modules/content/", 'xmlns:dsq'=>"http://www.disqus.com/", 'xmlns:dc'=>"http://purl.org/dc/elements/1.1/", 'xmlns:wp'=>"http://wordpress.org/export/1.0/") do
        xml.channel do
          Recipe.includes(:comments, :user).find_each do |r|
            xml.item do
              xml.title r.name
              xml.link "http://staging.hobocentral.net/tutorials/#{r.to_param}"
              xml['content'].encoded do
                xml.cdata r.body
              end
              xml['dsq'].thread_identifier "/tutorials/#{r.to_param}"
              xml['dsq'].post_date_gmt r.created_at.to_s.gsub(/ UTC$/, '')
              xml['dsq'].comment_status 'open'
              r.comments.each do |c|
                xml['wp'].comment_ do
                  xml['wp'].comment_id c.id
                  xml['wp'].comment_author c.user.username
                  xml['wp'].comment_author_email c.user.email_address
                  xml['wp'].comment_author_url ''
                  xml['wp'].comment_author_IP ''
                  xml['wp'].comment_date_gmt c.created_at.to_s.gsub(/ UTC$/, '')
                  xml['wp'].comment_content do
                    xml.cdata c.body
                  end
                  xml['wp'].comment_approved 1
                  xml['wp'].comment_parent 0
                end
              end
            end
          end
        end
      end
    end
    File.open("#{Rails.root}/recipe_comments.rss", "w") do |f|
      f.write builder.to_xml
    end
  end
end

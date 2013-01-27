atom_feed(:root_url => "#{request.base_url}/blog/#{params[:slug]}") do |feed|
  feed.title("Hobo Blog")
  feed.updated(@this.first.created_at)

  @this.each do |this|
    feed.entry(this) do |entry|
      entry.title(this.title)
      entry.content(this.body, :type => 'html')
      entry.updated(this.created_at)

      entry.author do |author|
        author.name(this.metadata['author'])
      end
    end
  end
end

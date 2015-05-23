module PostsHelper
  def tag_links(tags)
    tags.split(",").map { |tag| link_to tag.strip, tag_path(tag.strip) }.join(", ")
  end

  def tag_link(tag)
    link_to tag.name, tag_path(tag.name)
  end
end

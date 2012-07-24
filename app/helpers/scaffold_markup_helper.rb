module ScaffoldMarkupHelper

  def page_builder(&block)
    ScaffoldMarkup::Builders::PageBuilder.new(self, &block)
  end

  def url_helper
    ScaffoldMarkup::Helpers::UrlHelper.new(self)
  end

  def html
  	ScaffoldMarkup::Builders::TagBuilder.new
  end

end
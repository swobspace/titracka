class CrossReferenceDecorator < Draper::Decorator
  delegate_all

  def with_links
    linked = object.reference.reference_urls.map do |refurl|
      helpers.link_to "#{refurl.name}", refurl.url.gsub(/###IDENTIFIER###/, object.identifier)
    end
    "#{object.to_s}: #{linked.join("; ")}".html_safe
  end

end

class CrossReferenceDecorator < Draper::Decorator
  delegate_all

  def with_links
    unless object.reference.url.blank?
      helpers.link_to("#{object.reference.name}##{object.identifier}", 
                      object.reference.url.gsub(/###IDENTIFIER###/, object.identifier),
                      target: :blank)
    end
  end

end

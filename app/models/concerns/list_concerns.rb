module ListConcerns

  def name_for_selects
    # "#{NBSP * depth * 2}#{SUBTREE unless depth == 0}#{name}"
    name.to_s
  end
end

module ApplicationHelper
  def flash_symbol(type)
    if type.to_s == "notice"
      symbol = '<i class="fa-solid fa-check"></i>'
    else
      symbol = '<i class="fa-solid fa-exclamation"></i>'
    end
    symbol.html_safe
  end

  def flash_classes(type)
    if type.to_s == "notice"
      "bg-primary-200 border-2 border-primary-400 text-primary-800"
    else
      "bg-yellow-100 border-2 border-yellow-400 text-yellow-800"
    end
  end
end

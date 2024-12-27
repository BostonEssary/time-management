module ApplicationHelper
  def flash_symbol(type)
    symbol = '<i class="fa-solid fa-check"></i>'
    symbol.html_safe
  end
end

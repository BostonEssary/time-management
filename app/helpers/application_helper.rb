module ApplicationHelper
  EFFECT_THEMES = {
    "Relaxed"   => "sky",
    "Euphoric"  => "yellow",
    "Happy"     => "orange",
    "Uplifted"  => "pink",
    "Sleepy"    => "purple",
    "Focused"   => "green",
    "Creative"  => "fuchsia",
    "Energetic" => "red",
    "Hungry"    => "amber",
    "Talkative" => "blue"
  }.freeze

  EFFECT_ICONS = {
    "Energetic" => "fa-solid fa-bolt",
    "Relaxed" => "fa-solid fa-couch",
    "Sleepy" => "fa-solid fa-bed",
    "Focused" => "fa-solid fa-magnifying-glass",
    "Creative" => "fa-solid fa-brain",
    "Hungry" => "fa-solid fa-bowl-food",
    "Talkative" => "fa-solid fa-comments",
    "Happy" => "fa-solid fa-smile",
    "Euphoric" => "fa-solid fa-face-smile",
    "Uplifted" => "fa-solid fa-face-smile"
  }.freeze


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

  def effect_icon(effect, font_classes)
    p "effect for icon", effect
    icon = EFFECT_ICONS[effect]
    content_tag(:i, nil, class: icon + " #{font_classes}")
  end

  def effect_text(effect)
    theme = EFFECT_THEMES[effect]
    font_color = "text-#{theme}-700"
    font_classes = "text-sm #{font_color}"
    effect_icon(effect, font_classes) + " " + content_tag(:span, effect.capitalize, class: font_classes)
  end

  def effect_pill(effect)
    p "effect", effect
    theme = EFFECT_THEMES[effect]
    content_tag(:div, class: "bg-#{theme}-200 rounded-md p-1 w-fit") do
      effect_text(effect)
    end
  end
end

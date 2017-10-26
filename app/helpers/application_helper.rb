module ApplicationHelper

  def show_amount(price)
    return 'n/a' if price.blank?
    sprintf('%.2f EUR', price)
  end

  def link_to_drink_if_exists(drink)
    drink = Drink.find_by(:id => drink)
    if drink.nil?
      return "n/a"
    else
      return link_to drink do
        drink.name
      end
    end
  end
end

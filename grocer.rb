require 'pp'
require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  while i < collection.length do

    if name === collection[i][:item]
      return collection[i]
    end
    i += 1
    nil
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  results = []
  i = 0
  #binding.pry
  while i < cart.length do
    item_name = cart[i][:item]
    sought_item = find_item_by_name_in_collection(item_name, results)
    if sought_item
      sought_item[:count] += 1
    else
      cart[i][:count] = 1
      results << cart[i]
    end
    i += 1
  end
  results
end

def coupon_hash(c)
  rounded_unit_price = (c[:cost] / c[:num])
  {
    :item => "#{c[:item]} W/COUPON",
    :price => rounded_unit_price,
    :count => c[:num]
  }
end

def apply_coupon_to_cart(matching_item, coupon, cart)
  matching_item[:count] -= coupon[:num]
  item_with_coupon = coupon_hash(coupon)
  item_with_coupon[:clearance] = matching_item[:clearance]
  cart << item_with_coupon
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
while i < coupons.count do
  coupon = coupons[i]
  item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
  item_is_in_basket = !!item_with_coupon
  count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num]

  if item_is_in_basket and count_is_big_enough_to_apply
    apply_coupon_to_cart(item_with_coupon, coupon, cart)
  end
  i += 1
end

cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  results = []
  #binding.pry
  while i < cart.length do
    item = cart[i]

    if item[:clearance]
      discount = (item[:price] * 0.8).round(2)
      item[:price] = discount
    end
    i += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  ccart = consolidate_cart(cart)
  acart = apply_coupons(ccart, coupons)
  clear_cart = apply_clearance(acart)

  i = 0
  grand_total = 0
  while i < clear_cart.length do
    item = clear_cart[i]
    total_price_of_item = item[:price] * item[:count]
    grand_total += total_price_of_item
    i += 1
  end

  if grand_total > 100
    grand_total *= 0.9
  end

  grand_total
end

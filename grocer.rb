# let(:items) do
#   [
#     {:item => "AVOCADO", :price => 3.00, :clearance => true},
#     {:item => "KALE", :price => 3.00, :clearance => false},
#     {:item => "BLACK_BEANS", :price => 2.50, :clearance => false},
#     {:item => "ALMONDS", :price => 9.00, :clearance => false},
#     {:item => "TEMPEH", :price => 3.00, :clearance => true},
#     {:item => "CHEESE", :price => 6.50, :clearance => false},
#     {:item => "BEER", :price => 13.00, :clearance => false},
#     {:item => "PEANUTBUTTER", :price => 3.00, :clearance => true},
#     {:item => "BEETS", :price => 2.50, :clearance => false},
#     {:item => "SOY MILK", :price => 4.50, :clearance => true}
#   ]




def find_item_by_name_in_collection(name, collection)


  for i in 0...collection.length do
    if name == collection[i][:item]
      return collection[i]
    end
  end
  nil


  # Implement me first!
  #
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)




result = []

  for i in 0...cart.length do
    item_name = cart[i][:item]
  searched_item = find_item_by_name_in_collection(item_name, result)
    if searched_item != nil
      searched_item[:count] += 1
    else
      cart[i][:count] = 1
      result.push(cart[i])
    end
  end
  result

  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)

  i = 0

  while i < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[i][:item],cart)
    couponed_item_name = "#{coupons[i][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)

    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[i][:cost] / coupons[i][:num],
          :count => coupons[i][:num],
          :clearance => cart_item[:clearance]
        }

        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end
    end
    i += 1
  end
  cart


  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  i = 0

  while i < cart.length do
    if cart[i][:clearance]
      new_price = cart[i][:price] * 0.80
      new_price_rounded = new_price.round(2)
      cart[i][:price] = new_price_rounded
    end
    i += 1
  end
  cart
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)

  consolidate_cart = consolidate_cart(cart)

  couponed_cart = apply_coupons(consolidate_cart, coupons)

  final_cart = apply_clearance(couponed_cart)
  total = 0
  i = 0

  while i < final_cart.length do
    total += final_cart[i][:price] * final_cart[i][:count]
    i += 1
  end

  if total > 100
    total -= (total * 0.10)
  end
total

  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end

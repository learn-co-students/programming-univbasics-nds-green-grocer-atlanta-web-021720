def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  counter = 0 
  while counter < collection.length 
  if collection [counter] [:item] == name  
  return collection [counter]
end

counter +=1 
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  new_cart = []
  counter = 0 
  while counter < cart.length
  new_cart_item = find_item_by_name_in_collection{cart[counter][:item], new_cart}
  if new_cart_item != nil 
    new_cart_item[:count] +=1 
  else
    new_cart_item = {
      :item => cart[counter][:item],
      :price => [counter][:price],
      :clearance => cart[counter][:clearance],
      :count => 1 
    }
    new_cart << new_cart_item
  end 
  counter += 1 
end 

new_cart

    
  
  
  
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  
  #
  # REMEMBER: This method **should** update cart
  
  oupon_counter = 0
  while coupon_counter < coupons.length do
    cart_checker = find_item_by_name_in_collection(coupons[coupon_counter][:item], cart)
    coupon_item_name = "#{coupons[coupon_counter][:item]} W/COUPON"
    couponed_item_name_checker = find_item_by_name_in_collection(coupon_item_name, cart)
    if cart_checker && cart_checker[:count] >= coupons[coupon_counter][:num]
      if couponed_item_name_checker
        couponed_item_name_checker[:count] += coupons[coupon_counter][:num]
        cart_checker[:count] -= coupons[coupon_counter][:num]
      else
        couponed_item_name_checker = {
          item: coupon_item_name,
          price: coupons[coupon_counter][:cost] / coupons[coupon_counter][:num],
          clearance: cart_checker[:clearance],
          count: coupons[coupon_counter][:num]
        }
        cart << couponed_item_name_checker
        cart_checker[:count] -= coupons[coupon_counter][:num]
      end
    end
    coupon_counter += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  cart=[
  {:item => "AVOCADO", :price => 3.00, :clearance => true, :count => 3},
  {:item => "KALE",    :price => 3.00, :clearance => false, :count => 1}
]
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
end

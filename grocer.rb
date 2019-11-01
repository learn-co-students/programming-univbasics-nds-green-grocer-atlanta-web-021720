require 'pry'

def find_item_by_name_in_collection(name, collection)
  index = 0 
  while index < collection.length do 
    if collection[index][:item] == name 
      found = collection[index]
    end
    index += 1
  end
  found
end

def find_index_of_item_in_collection(name, collection)
  i = 0 
  while i < collection.length do 
    if collection[i][:item] == name
      index = i
    end
    i += 1
  end
  index
end

def consolidate_cart(cart)
  i = 0 
  streamlined_cart = []
  
  while i < cart.length
  cur_search = cart[i][:item]
  hash_cur_search = find_item_by_name_in_collection(cur_search, streamlined_cart)

  if hash_cur_search
    d = find_index_of_item_in_collection(cur_search, streamlined_cart)
    streamlined_cart[d][:count] += 1
  else
    cart[i][:count] = 1
    streamlined_cart << cart[i]
  end
  
  i += 1
end
streamlined_cart
end




def create_couponed_item_hash(cart_item_hash, coupon_hash)
  used_coupon_hash = {}
  used_item_name = "#{cart_item_hash[:item]} W/COUPON"
  
  used_coupon_hash[:item] = used_item_name
  used_coupon_hash[:price] = coupon_hash[:cost] / coupon_hash[:num]
  used_coupon_hash[:count] = coupon_hash[:num]
  used_coupon_hash[:clearance] = cart_item_hash[:clearance]
  
  used_coupon_hash
end




def apply_coupons(cart, coupons = {})
  coupon_hash_i = 0 
  cart_hash_i = 0
  
  while coupon_hash_i < coupons.length do 
    curr_coupon_item = coupons[coupon_hash_i][:item]
    search = find_item_by_name_in_collection(curr_coupon_item, cart)
   
    if search[:count] >= coupons[coupon_hash_i][:num]
      cart_hash_i = find_index_of_item_in_collection(curr_coupon_item, cart)

      h = create_couponed_item_hash(search, coupons[coupon_hash_i])
      
      cart[cart_hash_i][:count] -= h[:count]
      cart << h
      coupon_hash_i -= 1
    end
    coupon_hash_i += 1
    search = nil
  end
cart
end

def apply_clearance(cart)
  clearance_i = 0 
  while clearance_i < cart.length do 
    
    if cart[clearance_i][:clearance] == true
    cart[clearance_i][:price] = cart[clearance_i][:price] - (cart[clearance_i][:price] * 0.2)
    end
    
    clearance_i += 1
  end
  cart
end


def count_cart_items(cart)
  total_count_i = 0 
  count_total = 0
  while total_count_i < cart.length do
    count_total += cart[total_count_i][:count]
    total_count_i += 1
  end
  count_total
end


def checkout(cart, coupons)
consolidated_cart = consolidate_cart(cart)
coupons_applied = apply_coupons(consolidated_cart, coupons)
clearance_applied = apply_clearance(coupons_applied)
#binding.pry
grand_total = 0
grand_total_i = 0
while grand_total_i < clearance_applied.length do 
  grand_total += clearance_applied[grand_total_i][:price] * clearance_applied[grand_total_i][:count]
  grand_total_i += 1
end

if grand_total >= 100.0
  grand_total *= 0.9
end
grand_total
end

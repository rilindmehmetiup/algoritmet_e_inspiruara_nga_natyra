array = [1,2,3,4,5,6,7,8]
members_to_take = 3

parent_1 = array.shuffle
parent_2 = array.shuffle

child = []

puts "************************ Combining the Parents **************************************"
puts "We have the following parents..."
puts "Parent 1: #{parent_1}"
puts "Parent 2: #{parent_2}"
random_slice = rand(0..(array.length - members_to_take))

puts "Going to take #{members_to_take} members from Parent 1, starting from the index: #{random_slice}"
selected_members = parent_1[random_slice..(random_slice+members_to_take-1)]
puts "The selected members will be: #{selected_members}"

members_to_take.times do |i|
	child[random_slice+i]  = selected_members[i]
end

puts "Almost compelted child: #{child}"

selected_members.each do |value|
	parent_2.delete(value)
end

puts "Parent 2 removing selected members: #{selected_members} is left as: #{parent_2}"

difference = (array.length - child.length)

random_slice.times do |i|
	child[i] = parent_2[difference + i]
end

(array.length - child.length).times do |i|
	child[child.length] = parent_2[i]
end

puts "Final result child is #{child}"
puts "********************************* End ***********************************************"

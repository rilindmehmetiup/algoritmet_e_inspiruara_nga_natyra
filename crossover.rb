def evaluate_fitness(array)
	cost = 0
	array[0..array.length-2].each_with_index do |value, index|
		key = @travel_costs["#{value}x#{array[index+1]}"].nil? ? "#{array[index+1]}x#{value}" : "#{value}x#{array[index+1]}"
		cost += @travel_costs[key]
	end
	key = @travel_costs["#{array.last}x#{array.first}"].nil? ? "#{array.first}x#{array.last}" : "#{array.last}x#{array.first}"
	cost += @travel_costs[key]
	cost
end

def crossover(parent_1, parent_2)
	child = []

	random_slice = rand(0..(@array.length - @members_to_take))

	
	selected_members = parent_1[random_slice..(random_slice+@members_to_take-1)]
	

	@members_to_take.times do |i|
		child[random_slice+i]  = selected_members[i]
	end

	selected_members.each do |value|
		parent_2.delete(value)
	end

	difference = (@array.length - child.length)

	random_slice.times do |i|
		child[i] = parent_2[difference + i]
	end

	(@array.length - child.length).times do |i|
		child[child.length] = parent_2[i]
	end

	child
end

def rank_select(generation)
	ranked_generation = []
	population_size = generation.length
	f = (population_size * (population_size + 1 )) / 2
	probablities = []
	generation.sort_by{|gen| gen[:fitness]}.each_with_index do |item, index|
		rank = population_size - index
		probability = (rank.to_f/f.to_f)
		probablities << probability
		ranked_generation << {member: item[:member], rank: rank, probability: probability}
	end
	prob = rand(probablities.min..probablities.max)
	ranked_generation.each do |ranked_member|
		ranked_member[:value] = ranked_member[:probability] - prob	
	end
	return ranked_generation.sort_by{|gen| gen[:value].abs}.first[:member]
end

@array = [1,2,3,4,5,6,7,8]
@travel_costs = {}
@array.each_with_index do |value, index|
	@array[(index+1..@array.length)].each do |value1, index1|
		@travel_costs["#{value}x#{value1}"] = rand(1..30)
	end
end


@members_to_take = 3

population_size = 100
generation = []

#Gjenerimi i populates
population_size.times do
	new_member = @array.shuffle
	generation << {member: new_member, fitness: evaluate_fitness(new_member)}
end


parent_paris = []
(population_size-1).times do
	parent_paris << [rank_select(generation), rank_select(generation)]
end

puts "Parent Pairs: #{parent_paris.length}"

parent_1 = @array.shuffle
parent_2 = @array.shuffle

evaluate_fitness(parent_1)
child = crossover(parent_1, parent_2)
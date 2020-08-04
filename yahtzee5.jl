#Markov Chains Defined

#Base Markov Chains used for of-a-kind type combinations

MC = zeros(5, 5)
MC[1, 1] = 120/1296
MC[2, 1] = 900/1296
MC[3, 1] = 250/1296
MC[4, 2] = 25/1296
MC[5, 1] = 1/1296
MC[2, 2] = 120/216
MC[3, 2] = 80/216
MC[4, 2] = 15/216
MC[5, 2] = 1/216
MC[3, 3] = 25/36
MC[4, 3] = 10/36
MC[5, 3] = 1/36
MC[4, 4] = 5/6
MC[4, 5] = 1/6
MC[5, 5] = 1

MC6 = zeros(6, 6)
MC6[1, 1] = 3125/7776
MC6[2, 1] = 3125/7776
MC6[3, 1] = 1250/7776
MC6[4, 1] = 250/7776
MC6[5, 1] = 25/7776
MC6[6, 1] = 1/7776
MC6[2, 2] = 625/1296
MC6[3, 2] = 500/1296
MC6[4, 2] = 150/1296
MC6[5, 2] = 20/1296
MC6[6, 2] = 1/1296
MC6[3, 3] = 125/2296
MC6[4, 3] = 75/216
MC6[5, 3] = 15/216
MC6[6, 3] = 1/216
MC6[4, 4] = 25/36
MC6[5, 4] = 10/36
MC6[6, 4] = 1/36
MC6[5, 5] = 5/6
MC6[6, 5] = 1/6
MC6[6, 6] = 1


#Markov Chain for Small Straights

SSMC = zeros(4, 4)
SSMC[1, 1] = 108/1296
SSMC[2, 1] = 525/1296
SSMC[3, 1] = 582/1296
SSMC[4, 1] = 108/1296
SSMC[2, 2] = 64/216
SSMC[3, 2] = 122/216
SSMC[4, 2] = 30/216
SSMC[3, 3] = 25/36
SSMC[4, 3] = 11/36
SSMC[4, 4] = 1

#Markov Chain for Large Straights

LSMC = zeros(5, 5)
LSMC[1, 1] = 16/1296
LSMC[2, 1] = 260/1296
LSMC[3, 1] = 660/1296
LSMC[4, 1] = 336/1296
LSMC[5, 1] = 24/1296
LSMC[2, 2] = 27/216
LSMC[3, 2] = 111/216
LSMC[4, 2] = 72/216
LSMC[5, 2] = 6/216
LSMC[3, 3] = 16/36
LSMC[4, 3] = 18/36
LSMC[5, 3] = 2/36
LSMC[4, 4] = 5/6
LSMC[5, 4] = 1/6
LSMC[5, 5] = 1

#struct of type Moves includes all game combinations

mutable struct Moves
  one
  twos
  threes
  fours
  fives
  sixes
  three_OAK
  four_OAK
  full_house
  sm_straight
  lrg_straight
  yahtzee
  chance
end

#struct of type State includes current dice, remaining rolls in turn, remaining moves, and current score

mutable struct State
  dice :: Array
  remaining_rolls :: Int
  remaining_moves :: Moves
  score :: Int
end

@enum all_moves one=1 twos threes fours fives sixes three_OAK four_OAK five_OAK full_house sm_straight lrg_straight yahtzee chance

#HELPER FUNCTIONS

function mysum(list)
  """ returns sum of elements of input list """
  sumx = 0
  for elt in list
    sumx += elt
  end
  return sumx
end

function intersect(l1, l2)
  """ returns the intersection of two lists """
  intersection = []
  for element1 in l1
    for element2 in l2
      if element1 == element2
        if element1 in intersection
          function foo()
          end
        else
          push!(intersection, element1)
        end
      end
    end
  end
  return intersection
end

function count_d(dice)
  """ returns dictionary where keys are dice numbers and values are the number of times that die appears in the current dice """
  d = Dict()
  for i in (1:6)
    count = 0
    for die in dice
      (i == die) ? (count += 1) : count += 0
    end
    d[i] = count
  end
  return d
end

function max(array)
  """ returns the maximum element of a list """
  if length(array) == 0
    return nothing
  else
    maximum = -10
    for element in array
      if element > maximum
        maximum = element
      end
    end
    return maximum
  end
end

function max_value(d)
  """returns key value pair with highest value from a dictionary """
  max_v = -10
  k = 1
  for key in d
    value = d[key[1]]
    if value > max_v
      max_v = value
      k = key
    end
  end
  final = k
  for key in d
    value = d[key[1]]
    if value == max_v
      if key[1] > k[1]
        final = key
      else
        final = k
      end
    end
  end
  return final
end

function max_value_d(d)
  """ returns the maximum value of an input dictionary """
  max = -10
  for key in d
    value = d[key[1]]
    if value > max
      max = value
    end
  end
  return max
end

function geq(num1, num2)
  """ returns bool for whether num1 is greater than or equal to num2 """
  if num1 == num2
    return true
  elseif num1 > num2
    return true
  else
    return false
  end
end

function Input(prompt)
  print(prompt)
  readline()
end

function string_to_list(string)
  """ converts a string of numbers into a list of numbers """
  list = []
  for char in string
    if char in [',', ' ']
      function foo()
      end
    else
      x = parse(Int64, char)
      push!(list, x)
    end
  end
  return list
end

function string_to_move(string)
  """ since Input statements return strings, function converts input string in the corresponding move of enum type all_moves """
  if string == "ones"
    return one
  elseif string == "twos"
    return twos
  elseif string == "threes"
    return threes
  elseif string == "fours"
    return fours
  elseif string == "fives"
    return fives
  elseif string == "sixes"
    return sixes
  elseif string == "3 OAK"
    return three_OAK
  elseif string == "4 OAK"
    return four_OAK
  elseif string == "Full House"
    return full_house
  elseif string == "Sm. Straight"
    return sm_straight
  elseif string == "Lrg. Straight"
    return lrg_straight
  elseif string == "Yahtzee"
    return yahtzee
  elseif string == "Chance"
    return chance
  end
end

function sum_of_dice(state)
  """ returns sum of dice in current state """
  dice = state.dice
  sum = 0
  for die in dice
    sum += die
  end
  return sum
end

function subset(list1, list2)
  """ returns bool whether list1 is a subset of list2 """
  bool = true
  x = 1
  for elt in list1
    (elt in list2) ? (x = 1) : (bool = false)
  end
  return bool
end

function combination_satisfied(dice, move)
  """ returns a bool for whether specified combination is satisfied with current dice """
  if move == three_OAK
    d = count_d(dice)
    satisfied = false
    if geq((max_value_d(d)), 3)
      satisfied = true
    end
    return satisfied
  elseif move == four_OAK
    d = count_d(dice)
    satisfied = geq((max_value_d(d)), 4)
    return satisfied
  elseif move == full_house
    d = count_d(dice)
    satisfied = true
    for key in d
      value = d[key[1]]
      if value in [1, 4, 5]
        satisfied = false
      end
    end
    return satisfied
  elseif move == sm_straight
    satisfied1 = subset([1, 2, 3, 4], dice)
    satisfied2 = subset([2, 3, 4, 5], dice)
    satisfied3 = subset([3, 4, 5, 6], dice)
    satisfied = satisfied1 || satisfied2 || satisfied3
    return satisfied
  elseif move == lrg_straight
    satisfied1 = subset([1, 2, 3, 4, 5], dice)
    satisfied2 = subset([2, 3, 4, 5, 6], dice)
    satisfied = satisfied1 || satisfied2
    return satisfied
  elseif move == yahtzee
    d = count_d(dice)
    satisfied = false
    if max_value_d(d) == 5
      satisfied = true
    end
    return satisfied
  end
end

#DETERMINING OPTIMAL MOVE

function reaching_x(state, dice_number, OAK)
  """ given state, dice number, and desired OAK, function returns the probability of reaching desired combo """
  count = 0
  for die in state.dice
    (die == dice_number) ? (count += 1) : (x = 1)
  end
  if count == 0
    initial_state = zeros(6, 1)
    initial_state[1, 1] = 1.0
    probabilities = MC6^(state.remaining_rolls) * initial_state
    probability = probabilities[OAK+1, 1]
  else
    initial_state = zeros(5, 1)
    initial_state[count, 1] = 1.0
    probabilities = MC^(state.remaining_rolls) * initial_state
    probability = probabilities[OAK, 1]
  end
  return probability
end

function determine_ss_state(state, ss)
  """ determines how many dice of a small straight are already present in dice """
  intersection = intersect(state.dice, ss)
  return length(intersection)
end

function determine_ls_state(state, ls)
  """ determines how many dice of a large straight are already present in dice """
  intersection = intersect(state.dice, ls)
  return length(intersection)
end

function simpl_3OAK(state, die)
  """ returns probability of reaching 3 OAK given state and specified dice number. if 3 OAK of specified number
      is already satisfied, probability is 1.0 """
  c = count_d(state.dice)
  count = c[die]
  if geq(count, 3)
    prob = 1.0
  else
    prob = reaching_x(state, die, 3)
  end
  return prob
end

function upper_section_3OAK_probabilities(state)
  """ returns dictionary with probabilities of reaching 3 of a kinds for upper section """
  bools = state.remaining_moves
  Prob_Dict = Dict()
  if bools.one == false
    Prob_Dict[one] = simpl_3OAK(state, 1)
  end
  if bools.twos == false
    Prob_Dict[twos] = simpl_3OAK(state, 2)
  end
  if bools.threes == false
    Prob_Dict[threes] = simpl_3OAK(state, 3)
  end
  if bools.fours == false
    Prob_Dict[fours] = simpl_3OAK(state, 4)
  end
  if bools.fives == false
    Prob_Dict[fives] = simpl_3OAK(state, 5)
  end
  if bools.sixes == false
    Prob_Dict[sixes] = simpl_3OAK(state, 6)
  end
  return Prob_Dict
end

function lower_section_probabilities(state)
  """ returns a dictionary with probabilities of reaching combinations in the lower section """
  Prob_Dict = Dict()
  c = count_d(state.dice)
  bools = state.remaining_moves
  if bools.three_OAK == false
    probabilities = []
    for i in (1:6)
      if geq(c[i], 3)
        push!(probabilities, 1.0)
      else
        prob = reaching_x(state, i, 3)
        push!(probabilities, prob)
      end
    end
    Prob_Dict[three_OAK] = max(probabilities)
  end
  if bools.four_OAK ==  false
    probabilities = []
    for i in (1:6)
      if geq(c[i], 4)
        push!(probabilities, 1.0)
      else
        prob = reaching_x(state, i, 4)
        push!(probabilities, prob)
      end
    end
    Prob_Dict[four_OAK] = max(probabilities)
  end
  if bools.full_house == false
    if combination_satisfied(state.dice, full_house)
      Prob_Dict[full_house] = 1.0
    else
      Prob_Dict[full_house] = 0.001
    end
  end
  if bools.sm_straight == false
    possible_ss = [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6]]
    ss_probabilities = []
    for ss in possible_ss
      ss_state = determine_ss_state(state, ss)
      if ss_state != 0
        if ss_state == 4
          push!(ss_probabilities, 1.0)
        else
          initial_state = zeros(4, 1)
          initial_state[ss_state, 1] = 1.0
          probabilities = SSMC ^ (state.remaining_rolls) * initial_state
          probability = probabilities[4, 1]
          push!(ss_probabilities, probability)
        end
      end
    end
    if ss_probabilities == []
      Prob_Dict[sm_straight] = 0.001
    else
      ss_probability = max(ss_probabilities)
      Prob_Dict[sm_straight] = ss_probability
    end
  end
  if bools.lrg_straight == false
    possible_ls = [[1, 2, 3, 4, 5], [2, 3, 4, 5, 6]]
    ls_probabilities = []
    for ls in possible_ls
      ls_state = determine_ls_state(state, ls)
      if ls_state != 0
        if ls_state == 5
          push!(ls_probabilities, 1.0)
        else
          initial_state = zeros(5, 1)
          initial_state[ls_state, 1] = 1.0
          probabilities = LSMC ^ (state.remaining_rolls) * initial_state
          probability = probabilities[5, 1]
          push!(ls_probabilities, probability)
        end
      end
    end
    if ls_probabilities == []
      Prob_Dict(lrg_straight) = 0.001
    else
      ls_probability = max(ls_probabilities)
      Prob_Dict[lrg_straight] = ls_probability
    end
  end
  if bools.yahtzee == false
    c = count_d(state.dice)
    if max_value_d(c) == 5
      Prob_Dict[yahtzee] = 1.0
    else
      closest = max_value(c)[1]
      probability = reaching_x(state, closest, 5)
      Prob_Dict[yahtzee] = probability
    end
  end
  if bools.chance == false
    Prob_Dict[chance] = 0.10
  end
  return Prob_Dict
end

function all_probabilities(state)
  """ returns a dictionary with the probability of reaching each remaining move. if the combination
      is already satisfied in the current state, the probability is 1.0. for upper section probabilites,
      I am using the probability that you reach a 3 of a kind of that number """
  upper_section = upper_section_3OAK_probabilities(state)
  lower_section = lower_section_probabilities(state)
  d = merge!(+, upper_section, lower_section)
  return d
end

function upper_section_payoffs(state, die)
  """ returns the pay off of moves in the upper section """
  dice = state.dice
  score = state.score
  c = count_d(dice)
  number = c[die]
  payoff = number * die
  return payoff
end

function pay_off(state)
  """ returns of dictionary with pay offs of remaining moves """
  d = Dict()
  score = state.score
  bools = state.remaining_moves
  if bools.one == false
    raw = upper_section_payoffs(state, 1)
    weight = (raw/63) * 0.0933
    d[one] = raw/(375 - state.score) + weight
  end
  if bools.twos == false
    raw = upper_section_payoffs(state, 2)
    weight = (raw/63) * 0.0933
    d[twos] = raw/(375 - state.score) + weight
  end
  if bools.threes == false
    raw = upper_section_payoffs(state, 3)
    weight = (raw/63) * 0.0933
    d[threes] = raw/(375 - state.score) + weight
  end
  if bools.fours == false
    raw = upper_section_payoffs(state, 4)
    weight = (raw/63) * 0.0933
    d[fours] = raw/(375 - state.score) + weight
  end
  if bools.fives == false
    raw = upper_section_payoffs(state, 5)
    weight = (raw/63) * 0.0933
    d[fives] = raw/(375 - state.score) + weight
  end
  if bools.sixes == false
    raw = upper_section_payoffs(state, 6)
    weight = (raw/63) * 0.0933
    d[sixes] = raw/(375 - state.score) + weight
  end
  if bools.three_OAK == false
    pay_off = (sum_of_dice(state))/(375 - score)
    d[three_OAK] = pay_off
  end
  if bools.four_OAK == false
    pay_off = (sum_of_dice(state))/(375 - score)
    d[four_OAK] = pay_off
  end
  if bools.full_house == false
    pay_off = 25/(375 - score)
    d[full_house] = pay_off
  end
  if bools.sm_straight == false
    pay_off = 30/(375 - score)
    d[sm_straight] = pay_off
  end
  if bools.lrg_straight == false
    pay_off = 40/(375 - score)
    d[lrg_straight] = pay_off
  end
  if bools.chance == false
    sum = sum_of_dice(state)
    pay_off = sum/(375 - score)
    d[chance] = pay_off
  end
  if bools.yahtzee == false
    pay_off = 50/(375 - score)
    d[yahtzee] = pay_off
  end
  return d
end

function generate_best_fit_tuples(state)
  """ generates a list of tuples of form (move, payoff, probability) """
  d1 = pay_off(state)
  d2 = all_probabilities(state)
  tuples = []
  for pair in d1
    move = pair[1]
    po = pair[2]
    prob = d2[move]
    push!(tuples, (move, po, prob))
  end
  return tuples
end

function model_distance(state)
  """ using a generated best fit line relating the relative payoffs/probabilities of available moves,
      function returns a dictionary displaying how far move data points (payoff, probability) are from
      the best fit line """
  tuples = generate_best_fit_tuples(state)
  slope = -2.2
  intercept = .3
  d = Dict()
  for tuple in tuples
    move = tuple[1]
    po = tuple[2]
    prob = tuple[3]
    point = (po, prob)
    y = slope * po + intercept
    difference = prob - y
    d[move] = difference
  end
  return d
end

function opt_move(state)
  """ returns optimal move given the state of the game """
  distances = model_distance(state)
  best = max_value(distances)
  return best[1]
end

#GAME SIMULATION

function update_board(board, r, c, new_value)
  """ takes current board and replaces value at (r, c) with new_value """
  board[r, c] = new_value
  board[17, 2] = total_score("You", board)
  board[17, 3] = total_score("Computer", board)
  upper_score_man = upper_section_score("You", board)
  upper_score_comp = upper_section_score("Computer", board)
  if geq(upper_score_man, 63)
    board[8, 2] = 35
  elseif geq(upper_score_man, 63)
    board[8, 3] = 35
  else
    function foo()
    end
  end
  return board
end

function random_first_roll()
  """ generates a random roll of 5 6-sided die """
  p = [1, 2, 3, 4, 5, 6]
  return [rand(p), rand(p), rand(p), rand(p), rand(p)]
end

function take_move(board, state, player, move)
  """ updates game state by a) updating board to reflect new category and total score,
  b) updating the state by taking combination out of remaining_moves and c) updates
  state by updating total score """
  bools = state.remaining_moves
  if player == "You"
    c = 2
  else
    c = 3
  end
  if move == one
    value = upper_section_payoffs(state, 1)
    update_board(board, 2, c, value)
    bools.one = true
  elseif move == twos
    value = upper_section_payoffs(state, 2)
    update_board(board, 3, c, value)
    bools.twos = true
  elseif move == threes
    value = upper_section_payoffs(state, 3)
    update_board(board, 4, c, value)
    bools.threes = true
  elseif move == fours
    value = upper_section_payoffs(state, 4)
    update_board(board, 5, c, value)
    bools.fours = true
  elseif move == fives
    value = upper_section_payoffs(state, 5)
    update_board(board, 6, c, value)
    bools.fives = true
  elseif move == sixes
    value = upper_section_payoffs(state, 6)
    update_board(board, 7, c, value)
    bools.sixes = true
  elseif move == three_OAK
    if combination_satisfied(state.dice, three_OAK)
      value = sum_of_dice(state)
      update_board(board, 9, c, value)
    else
      update_board(board, 9, c, 0)
    end
    bools.three_OAK = true
  elseif move == four_OAK
    if combination_satisfied(state.dice, four_OAK)
      value = sum_of_dice(state)
      update_board(board, 10, c, value)
    else
      update_board(board, 10, c, 0)
    end
    bools.four_OAK = true
  elseif move == full_house
    if combination_satisfied(state.dice, full_house)
      value = 25
      update_board(board, 11, c, value)
    else
      update_board(board, 11, c, 0)
    end
    bools.full_house = true
  elseif move == sm_straight
    if combination_satisfied(state.dice, sm_straight)
      value = 30
      update_board(board, 12, c, value)
    else
      update_board(board, 12, c, 0)
    end
    bools.sm_straight = true
  elseif move == lrg_straight
    if combination_satisfied(state.dice, lrg_straight)
      value = 40
      update_board(board, 13, c, value)
    else
      update_board(board, 13, c, 0)
    end
    bools.lrg_straight = true
  elseif move == yahtzee
    ls = false
    if combination_satisfied(state.dice, yahtzee)
      if board[14, c] != 50
        value = 50
        update_board(board, 14, c, value)
      else
        current = board[15, c]
        new = current + 100
        update_board(board, 15, c, new)
        die = state.dice[1]
        if die == 1
          (bools.one == false) ? (take_move(board, state, player, one)) : (ls = true)
        elseif die == 2
          (bools.twos == false) ? (take_move(board, state, player, twos)) : (ls = true)
        elseif die == 3
          (bools.threes == false) ? (take_move(board, state, player, threes)) : (ls = true)
        elseif die == 4
          (bools.fours == false) ? (take_move(board, state, player, fours)) : (ls = true)
        elseif die == 5
          (bools.fives == false) ? (take_move(board, state, player, fives)) : (ls = true)
        elseif die == 6
          (bools.sixes == false) ? (take_move(board, state, player, sixes)) : (ls = true)
        end
        if ls
          p = pay_off(state)
          pop!(p, yahtzee)
          new_move = max_value(p)[1]
          if new_move == three_OAK
            update_board(board, 9, c, sum_of_dice(state))
            bools.three_OAK = true
          elseif new_move == four_OAK
            update_board(board, 10, c, sum_of_dice(state))
            bools.four_OAK = true
          elseif new_move == full_house
            update_board(board, 11, c, 25)
            bools.full_house = true
          elseif new_move == sm_straight
            update_board(board, 12, c, 30)
            bools.sm_straight = true
          elseif new_move == lrg_straight
            update_board(board, 13, c, 40)
            bools.lrg_straight = true
          elseif new_move == chance
            update_board(board, 16, c, sum_of_dice(state))
            bools.chance = true
          end
        end
      end
    else
      update_board(board, 14, c, 0)
      bools.yahtzee = true
    end
    """ since you can get multiple yahtzees per game, taking yahtzee will not remove yahtzee from remaining moves """
  elseif move == chance
    value = sum_of_dice(state)
    update_board(board, 16, c, value)
    bools.chance = true
  elseif move == 1
    """ when no combinations were satisfied """
    println("Uh Oh...")
  elseif move == "quit"
    return "Quit Game"
    end
  state.score = board[17, c]
end

function re_roll(current_dice, positions_to_keep)
  """ given the dice positions a player wants to keep (for example, 1=first die),
  re_roll generates new random dice numbers for all dice *not* specified in
    positions_to_keep list """
  d = Dict()
  for i in (1:5)
    d[i] = current_dice[i]
    if i in positions_to_keep
      function foo()
      end
    else
      d[i] = rand([1, 2, 3, 4, 5, 6])
    end
  end
  return [d[1], d[2], d[3], d[4], d[5]]
end

function determining_keep_positions(state, move)
  """ given the current state and desired combination, funtion returns a list
  for which dice positions player should strategically keep """
  dice = state.dice
  x = 1
  keep = []
  if move == one
    for i in (1:5)
      (dice[i] == 1) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  elseif move == twos
    for i in (1:5)
      (dice[i] == 2) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  elseif move == threes
    for i in (1:5)
      (dice[i] == 3) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  elseif move == fours
    for i in (1:5)
      (dice[i] == 4) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  elseif move == fives
    for i in (1:5)
      (dice[i] == 5) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  elseif move == sixes
    for i in (1:5)
      (dice[i] == 6) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  elseif move == three_OAK
    d = count_d(dice)
    m = max_value(d)
    die = m[1]
    for i in (1:5)
      (dice[i] == die) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  elseif move == four_OAK
    d = count_d(dice)
    m = max_value(d)
    die = m[1]
    for i in (1:5)
      (dice[i] == die) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  elseif move == full_house
    d = count_d(dice)
    m1 = max_value(d)
    num1 = m1[1]
    pop!(d, num1)
    m2 = max_value(d)
    num2 = m2[1]
    for i in (1:5)
      (dice[i] in [num1, num2]) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  elseif move == sm_straight
    l1 = intersect([1, 2, 3, 4], dice)
    l2 = intersect([2, 3, 4, 5], dice)
    l3 = intersect([3, 4, 5, 6], dice)
    num1 = length(l1)
    num2 = length(l2)
    num3 = length(l3)
    closest = max([num1, num2, num3])
    if closest == num1
      for i in (1:5)
        (dice[i] in l1) ? (push!(keep, i)) : (x = 1)
        (dice[i] in l1) ? (remove!(l1, dice[i])) : (x = 1)
      end
    elseif closest == num2
      for i in (1:5)
        (dice[i] in l2) ? (push!(keep, i)) : (x = 1)
        (dice[i] in l2) ? (remove!(l2, dice[i])) : (x = 1)
      end
    elseif closest == num3
      for i in (1:5)
        (dice[i] in l3) ? (push!(keep, i)) : (x = 1)
        (dice[i] in l3) ? (remove!(l3, dice[i])) : (x = 1)
      end
    end
    return keep
  elseif move == lrg_straight
    l1 = intersect([1, 2, 3, 4, 5], dice)
    l2 = intersect([2, 3, 4, 5, 6], dice)
    num1 = length(l1)
    num2 = length(l2)
    closest = max([num1, num2])
    if closest == num1
      for i in (1:5)
        (dice[i] in l1) ? (push!(keep, i)) : (x = 1)
        (dice[i] in l1) ? (remove!(l1, dice[i])) : (x = 1)
      end
    elseif closest == num2
      for i in (1:5)
        (dice[i] in l2) ? (push!(keep, i)) : (x = 1)
        (dice[i] in l2) ? (remove!(l2, dice[i])) : (x = 1)
      end
    end
    return keep
  elseif move == yahtzee
    d = count_d(dice)
    m = max_value(d)
    die = m[1]
    for i in (1:5)
      (dice[i] == die) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  elseif move == chance
    for i in (1:5)
      (geq(dice[1], 4)) ? (push!(keep, i)) : (x = 1)
    end
    return keep
  else
    return []
  end
end

#Score Calculations

function upper_section_score(player, board)
  """ calculates total score of the upper section to determine if upper section bonus has been satisfied """
  score = 0
  if player == "You"
    for i in (2:7)
      if typeof(board[i, 2]) == Int64
        score += (board[i, 2])
      else
        function foo()
        end
      end
    end
  else
    for i in (2:7)
      if typeof(board[i, 3]) == Int64
        score += (board[i, 3])
      else
        function foo()
        end
      end
    end
  end
  return score
end

function total_score(player, board)
  """ calculates the total score given input player and current board """
  score = 0
  if player == "You"
    for i in (2:15)
      if typeof(board[i, 2]) == Int64
        score += (board[i, 2])
      else
        function foo()
        end
      end
    end
  else
    for i in (2:15)
      if typeof(board[i, 3]) == Int64
        score += (board[i, 3])
      else
        function foo()
        end
      end
    end
  end
  return score
end

#Determining Final Move

function possible_final_moves(state)
  """ returns a list of combinations that are satisfied. since you can always take upper section combos,
      these combos are always satisfied """
  probs = all_probabilities(state)
  bools = state.remaining_moves
  satisfied = []
  for key in probs
    if probs[key[1]] == 1.0
      push!(satisfied, key[1])
    end
  end
  if bools.one == false
    push!(satisfied, one)
  end
  if bools.twos == false
    push!(satisfied, twos)
  end
  if bools.threes == false
    push!(satisfied, threes)
  end
  if bools.fours == false
    push!(satisfied, fours)
  end
  if bools.fives == false
    push!(satisfied, fives)
  end
  if bools.sixes == false
    push!(satisfied, sixes)
  end
  if bools.chance == false
    push!(satisfied, chance)
  end
  return satisfied
end

function determine_final_move(board, player, state, list)
  """ given the state of the game and a list of satisfied combinations, function
      returns the move that yields the highest pay off """
  if player == "You"
    c = 2
  else
    c = 3
  end
  payoffs = pay_off(state)
  bools = state.remaining_moves
  m = -1
  take = 1
  if list == []
    if bools.yahtzee == false
      if board[14, c] != 50
        return yahtzee
      else
        if bools.full_house == false
          return full_house
        elseif bools.four_OAK == false
          return four_OAK
        elseif bools.lrg_straight == false
          return lrg_straight
        elseif bools.three_OAK == false
          return three_OAK
        elseif bools.sm_straight == false
          return sm_straight
        elseif bools.chance == false
          return chance
        end
      end
    else
      if bools.full_house == false
        return full_house
      elseif bools.four_OAK == false
        return four_OAK
      elseif bools.lrg_straight == false
        return lrg_straight
      elseif bools.three_OAK == false
        return three_OAK
      elseif bools.sm_straight == false
        return sm_straight
      elseif bools.chance == false
        return chance
      end
    end
  end
  for move in list
    po = payoffs[move]
    if po > m
      take = move
      m = po
    end
  end
  return take
end

#Defining initial board, initial statem = player1 state, initial statec = player2 state

iboard = ["Scoreboard" "You" "Computer"; "ones (sum of 1s)" "-" "-"; "twos (sum of 2s)" "-" "-"; "threes (sum of 3s)" "-" "-"; "fours (sum of 4s)" "-" "-";
      "fives (sum of 5s)" "-" "-"; "sixes (sum of 6s)" "-" "-"; "Lower Section Bonus (x points away)" 0 0;
      "3 Of a Kind (sum of dice)" "-" "-"; "4 Of a Kind (sum of dice)" "-" "-";
      "Full House (25 pts.)" "-" "-"; "Small Straight (30 pts.)" "-" "-";
      "Large Straight (40 pts.)" "-" "-"; "Yahtzee (50 pts.)" "-" "-";
      "Additional Yahtzees (100 pts. each)" 0 0; "Chance" "-" "-"; "Total Score" 0 0]

istatem = State(random_first_roll(), 2, Moves(false, false, false, false, false, false, false, false, false, false, false, false, false), 0)

istatec = State(random_first_roll(), 2, Moves(false, false, false, false, false, false, false, false, false, false, false, false, false), 0)


#PLAY FUNCTION
#play() simulates a game between computer program and a human
#play_computer() simulates a game between two computers

function play()
  board = iboard
  statem = istatem
  statec = istatec
  for i in (1:26)
    if !(i % 2 == 0)
      player = "You"
      println(display(board))
      statem.dice = random_first_roll()
      statem.remaining_rolls = 2
      bools = statem.remaining_moves
      println("First Roll: ")
      println(statem.dice)
      for i in (1:2)
        keep_string = Input("What dice positions would you like to keep? ")
        keep = string_to_list(keep_string)
        new = re_roll(statem.dice, keep)
        statem.dice = new
        if i == 1
          println("Second roll: ")
          println(statem.dice)
        else
          println("Your final dice are: ")
          println(statem.dice)
        end
        statem.remaining_rolls = statem.remaining_rolls - 1
      end
      string_move = Input("What move would you like to make? ")
      move = string_to_move(string_move)
      take_move(board, statem, player, move)
    else
      player = "Computer"
      statec.dice = random_first_roll()
      statec.remaining_rolls = 2
      bools = statec.remaining_moves
      println("First Roll: ")
      println(statec.dice)
      for i in (1:2)
        move = opt_move(statec)
        println("going for...")
        println(move)
        keep = determining_keep_positions(statec, move)
        new = re_roll(statec.dice, keep)
        statec.dice = new
        if i == 1
          println("Second roll: ")
          println(statec.dice)
        else
          println("Final roll: ")
          println(statec.dice)
        end
        statec.remaining_rolls = statec.remaining_rolls - 1
      end
      l = possible_final_moves(statec)
      move = determine_final_move(board, player, statec, l)
      if i == 26
        display(board)
      end
      take_move(board, statec, player, move)
      if !(move == 1)
        println("I took $move")
      end
    end
  end
  println("Final Board: ")
  display(board)
end

function play_computer()
  iboard = ["Scoreboard" "You" "Computer"; "ones (sum of 1s)" "-" "-"; "twos (sum of 2s)" "-" "-"; "threes (sum of 3s)" "-" "-"; "fours (sum of 4s)" "-" "-";
        "fives (sum of 5s)" "-" "-"; "sixes (sum of 6s)" "-" "-"; "Lower Section Bonus (x points away)" 0 0;
        "3 Of a Kind (sum of dice)" "-" "-"; "4 Of a Kind (sum of dice)" "-" "-";
        "Full House (25 pts.)" "-" "-"; "Small Straight (30 pts.)" "-" "-";
        "Large Straight (40 pts.)" "-" "-"; "Yahtzee (50 pts.)" "-" "-";
        "Additional Yahtzees (100 pts. each)" 0 0; "Chance" "-" "-"; "Total Score" 0 0]
  board = iboard
  istatem = State(random_first_roll(), 2, Moves(false, false, false, false, false, false, false, false, false, false, false, false, false), 0)
  istatec = State(random_first_roll(), 2, Moves(false, false, false, false, false, false, false, false, false, false, false, false, false), 0)
  statem = istatem
  statec = istatec
  for i in (1:26)
    if !(i % 2 == 0)
      player = "You"
      statem.dice = random_first_roll()
      statem.remaining_rolls = 2
      bools = statem.remaining_moves
      println("First Roll: ")
      println(statem.dice)
      for i in (1:2)
        move = opt_move(statem)
        println("going for...")
        println(move)
        keep = determining_keep_positions(statem, move)
        new = re_roll(statem.dice, keep)
        statem.dice = new
        if i == 1
          println("Second roll: ")
          println(statem.dice)
        else
          println("Final roll: ")
          println(statem.dice)
        end
        statem.remaining_rolls = statem.remaining_rolls - 1
      end
      l = possible_final_moves(statem)
      move = determine_final_move(board, player, statem, l)
      take_move(board, statem, player, move)
      println("You took $move")
    else
      player = "Computer"
      statec.dice = random_first_roll()
      statec.remaining_rolls = 2
      bools = statec.remaining_moves
      println("First Roll: ")
      println(statec.dice)
      for i in (1:2)
        move = opt_move(statec)
        println("going for...")
        println(move)
        keep = determining_keep_positions(statec, move)
        new = re_roll(statec.dice, keep)
        statec.dice = new
        if i == 1
          println("Second roll: ")
          println(statec.dice)
        else
          println("Final roll: ")
          println(statec.dice)
        end
        statec.remaining_rolls = statec.remaining_rolls - 1
      end
      l = possible_final_moves(statec)
      move = determine_final_move(board, player, statec, l)
      take_move(board, statec, player, move)
      println("Computer took $move")
    end
  end
  println("You state:")
  println(statem)
  println("Computer state: ")
  println(statec)
  println("Final Board: ")
  display(board)
  return(board[17, 2], board[17, 3])
end

#SCORE ANALYSIS

function average(list)
  len = length(list)
  s = sum(list)
  return s/len
end

function average_score()
  all_scores = []
  for i in (1:10)
    x = play_computer()
    push!(all_scores, x[1])
    push!(all_scores, x[2])
  end
  println(average(all_scores))
  return all_scores
end

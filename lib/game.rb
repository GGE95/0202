class Game
  attr_accessor :combinaisons


  def initialize
    @array = Array.new(10," ")
  end

  #On récupère le nom des joueurs
  def declaration
    puts "Joueur 1, rentre ton nom :\n"
    print "> "
    user1_name = gets.chomp
    @player1 = Player.new(user1_name, "X")
    puts "Joueur 2, rentre ton nom :\n"
    print "> "
    user2_name = gets.chomp
    @player2 = Player.new(user2_name, "O")
  end

  #On dessine le morpion
  def chart
    puts "\nVoici la grille :\n\n"
    puts " #{@array[1]} | #{@array[2]} | #{@array[3]}"
    puts "-" * 3 + "+" + "-" * 3 + "+" + "-" * 3
    puts " #{@array[4]} | #{@array[5]} | #{@array[6]}"
    puts "-" * 3 + "+" + "-" * 3 + "+" + "-" * 3
    puts " #{@array[7]} | #{@array[8]} | #{@array[9]}\n\n"
    @array[0] = "N"
  end

  #On définit le processus des tours de jeu
  def turn
    @player_active = @player2
    while @winner != true && self.neutral != true
      @player_active = @player_active == @player1 ? @player2 : @player1
      puts "A présent, c'est au tour de #{@player_active.name}."
      puts "Choisis un chiffre entre 1 et 9."
      print "> "
      target = gets.chomp.to_i
      while @array[target] != " "
        puts "Soit t'as visé à côté, soit la case est déjà prise. Dans tous les cas, choisis-en une autre, et une bonne cette fois !"
        print "> "
      target = gets.chomp.to_i
      end
      @array[target] = @player_active.index
      self.chart
      self.win
    end
    if @winner == true
      puts "#{@player_active.name} a gagné !!" 
    else
      puts "Match nul pour #{@player1.name} et #{@player2.name}, balle au centre"
    end
  end

  #Méthode qui check s'il y a un vainqueur
  def win
    @combinaisons = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    @winner = false
    @combinaisons.each do |comb|
      values = comb.map { |position| @array[position] }
      if values.all? {|value| value == @player_active.index}
        @winner = true
        
      end
    end
    return @winner
  end

  #Méthode qui check si le jeu se termine par score nul
  def neutral
    if @array.none? { |element| element == " " }
      return true
    else
      return false
    end
  end

  #Proposition d'une autre partie
  def other_game
    puts "Voulez-vous faire une autre partie ?"
    puts "Si oui, tape 1"
    puts "Si non, tape 2"
    print "> "
    new_game = gets.chomp
    case new_game
    when "1"
      Game.new.perform 
    when "2"
      puts "Très bien, tchao !"
    else puts "T'as rien compris. Va te faire... !"
    end
  end

  #Moteur pour faire tourner le jeu
  def perform
    self.declaration
    self.chart
    self.turn
    self.other_game
  end

end
class AddCoatOfArmsToCitiesAndTowns < ActiveRecord::Migration[7.1]
  def up
    add_column :cities_and_towns, :coat_of_arms, :string

    data = [
      {"city" => "Daugavpils", "coat_of_arms" => "https://upload.wikimedia.org/wikipedia/commons/5/51/Coat_of_arms_of_Daugavpils.svg"},
      {"city" => "Jelgava", "coat_of_arms" => "https://commons.wikimedia.org/wiki/Category:Coats_of_arms_of_Jelgava"},
      {"city" => "Jurmala", "coat_of_arms" => "https://upload.wikimedia.org/wikipedia/commons/1/1b/Coat_of_Arms_of_Jūrmala.svg"},
      {"city" => "Liepaja", "coat_of_arms" => "https://upload.wikimedia.org/wikipedia/commons/1/11/Coat_of_Arms_of_Liepāja.svg"},
      {"city" => "Rezekne", "coat_of_arms" => "https://commons.wikimedia.org/wiki/Category:Coats_of_arms_of_Rēzekne"},
      {"city" => "Riga", "coat_of_arms" => "https://upload.wikimedia.org/wikipedia/commons/8/84/Coat_of_Arms_of_Riga.svg"},
      {"city" => "Ventspils", "coat_of_arms" => "https://upload.wikimedia.org/wikipedia/commons/5/5f/Coat_of_Arms_of_Ventspils.svg"},
      {"city" => "Sigulda", "coat_of_arms" => "https://commons.wikimedia.org/wiki/Category:Coats_of_arms_of_Sigulda"},
      {"city" => "Cesis", "coat_of_arms" => "https://upload.wikimedia.org/wikipedia/commons/4/4e/C%C4%93sis_COA.svg"},
      {"city" => "Kuldiga", "coat_of_arms" => "https://upload.wikimedia.org/wikipedia/commons/2/24/Coat_of_Arms_of_Kuld%C4%ABga.svg"}
    ]

    data.each do |item|
      CityAndTown.where(name: item["city"]).update_all(coat_of_arms: item["coat_of_arms"])
    end
  end

  def down
    remove_column :cities_and_towns, :coat_of_arms
  end
end

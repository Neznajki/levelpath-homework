class AddCoatOfArmsToCitiesAndTowns < ActiveRecord::Migration[7.1]
  def up
    add_column :cities_and_towns, :coat_of_arms, :string

    data = [
      {
        "city": "Daugavpils",
        "coat_of_arms": "https://upload.wikimedia.org/wikipedia/commons/a/a2/Coat_of_arms_of_Daugavpils.svg"
      },
      {
        "city": "Jelgava",
        "coat_of_arms": "https://upload.wikimedia.org/wikipedia/commons/e/e4/Jelgava_COA_small.svg"
      },
      {
        "city": "Jurmala",
        "coat_of_arms": "https://upload.wikimedia.org/wikipedia/commons/e/ea/Coat_of_Arms_of_J%C5%ABrmala.svg"
      },
      {
        "city": "Liepaja",
        "coat_of_arms": "https://upload.wikimedia.org/wikipedia/commons/0/03/Coat_of_Arms_of_Liep%C4%81ja.svg"
      },
      {
        "city": "Rezekne",
        "coat_of_arms": "https://upload.wikimedia.org/wikipedia/commons/5/5a/Coat_of_Arms_of_R%C4%93zekne.svg"
      },
      {
        "city": "Riga",
        "coat_of_arms": "https://upload.wikimedia.org/wikipedia/commons/9/99/Greater_Coat_of_Arms_of_Riga_-_for_display.svg"
      },
      {
        "city": "Ventspils",
        "coat_of_arms": "https://upload.wikimedia.org/wikipedia/commons/f/f3/Coat_of_Arms_of_Ventspils.svg"
      },
      {
        "city": "Sigulda",
        "coat_of_arms": "https://upload.wikimedia.org/wikipedia/commons/f/f6/Coat_of_Arms_of_Sigulda.svg"
      },
      {
        "city": "Cesis",
        "coat_of_arms": "https://upload.wikimedia.org/wikipedia/commons/9/94/Cesis_COA.svg"
      },
      {
        "city": "Kuldiga",
        "coat_of_arms": "https://upload.wikimedia.org/wikipedia/commons/4/42/Kuld%C4%ABgas_novads_COA.svg"
      }
    ]

    data.each do |item|
      CityAndTown.where(name: item["city"]).update_all(coat_of_arms: item["coat_of_arms"])
    end
  end

  def down
    remove_column :cities_and_towns, :coat_of_arms
  end
end

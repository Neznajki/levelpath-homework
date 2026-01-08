class SeedCitiesAndTowns < ActiveRecord::Migration[7.1]
  def up
    cities = %w[
      Daugavpils
      Jelgava
      Jurmala
      Liepaja
      Rezekne
      Riga
      Ventspils
      Sigulda
      Cesis
      Kuldiga
    ]

    cities.each do |city_name|
      CityAndTown.find_or_create_by!(name: city_name)
    end
  end

  def down
    CityAndTown.delete_all
  end
end

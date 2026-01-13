require 'rails_helper'

RSpec.describe "/search", type: :request do
  #this expected_result is flaky I wouldn't expect that contents always would be the same. I would rather suggest checking that it contains something or mock an external source to make sure data won't change.
  let(:expected_result){
    [
      "Pils, 4B, Pils iela, Sigulda, Siguldas novads, LV-2150, Latvija",
      "Sigulda, 6, Pils iela, Sigulda, Siguldas novads, LV-2150, Latvija",
      "Kaķis, 8A, Pils iela, Sigulda, Siguldas novads, LV-2150, Latvija",
      "Kaķu māja, 8, Pils iela, Sigulda, Siguldas novads, LV-2150, Latvija"
    ]
  }

  it "returns all hotels with Pils from Sigulda" do

    get("/api/search.json", params: {city: "Sigulda", q: "Pils"})

    parsed_response = JSON.parse(response.body)
    names = parsed_response.map{|el| el["display_name"]}

    expect(names).to eq(expected_result)
  end

  it "returns result under 100ms" do
    start_time = Time.now
    get("/api/search.json", params: {city: "Sigulda", q: "Pils"})
    end_time = Time.now

    request_time = end_time - start_time

    expect(request_time.to_f).to be < 0.1 # under 100ms
    parsed_response = JSON.parse(response.body)
    expect(parsed_response.length).to be > 0
  end

  it "it search by query" do
    full_text = "Test Text just for search " + rand(100000).to_s
    city_record = CityAndTown.find_or_create_by(name: "Riga")
    Hotel.create(city_and_town: city_record, display_name: full_text)
    get("/api/search.json", params: {q: "Test Text just for search"})

    expect(response.body).to include(full_text)
    expect(response.body).to include("{\"name\":\"Riga\",\"coat_of_arms\":\"https://upload.wikimedia.org/wikipedia/commons/9/99/Greater_Coat_of_Arms_of_Riga_-_for_display.svg\"}")
  end

  it "reimport soft removes outdated records" do
    full_text = "Test Text just for search " + rand(100000).to_s
    city_record = CityAndTown.find_or_create_by(name: "Riga")
    Hotel.create(city_and_town: city_record, display_name: full_text)
    WarmupService.call
    get("/api/search.json", params: {q: "Test Text just for search"})

    expect(response.body).to eq("[]")

    hotels = Hotel.where(display: false)
    assert_equal 1, hotels.count

    assert_equal full_text, hotels[0].display_name
    assert_equal city_record, hotels[0].city_and_town
  end
end

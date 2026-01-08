require 'rails_helper'

RSpec.describe "/search", type: :request do
  it "returns result under 100ms" do
    get("/api/search.json", params: {city: "Sigulda", q: "Pils"}) # Warmup
    start_time = Time.now
    get("/api/search.json", params: {city: "Sigulda", q: "Pils"})
    end_time = Time.now

    request_time = end_time - start_time

    expect(request_time.to_f).to be < 0.1 # under 100ms
  end

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
end

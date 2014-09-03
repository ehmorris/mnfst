require 'spec_helper'

describe KeysController do
  it 'produces a concatenation of all the text signed by the key' do
    status1 = create(:status)
    key = status1.key
    status2 = create(:status, key: key)

    get :show, id: key.keyid, format: 'asc'

    expect(response.body).to eq("#{status1.signed_body}\n#{status2.signed_body}")
  end
end

require 'spec_helper'
require 'sig_exception'

describe StatusesController do
  context '#create' do
    it 'produces a 400 on SigException' do
      status = double('status')
      status.stub(:save).and_raise(SigException, "foo bar")
      Status.stub(new: status)

      post :create, status: { signed_body: "baz" }

      expect(response.body).to eq("foo bar")
    end
  end

  context '#show' do
    it 'produces the signature when requested with the ASC format' do
      status = create(:status)

      get :show, hexid: status.hexid, format: 'asc'

      expect(response.body).to eq(status.signed_body)
    end
  end
end

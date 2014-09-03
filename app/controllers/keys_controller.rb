class KeysController < ApplicationController
  def show
    key = Key.find_by_keyid(params[:id].sub("0x", ""))
    statuses = key.statuses

    respond_to do |format|
      format.html { @key = key; @statuses = statuses }
      format.asc { render text: statuses.map(&:signed_body).join("\n") }
    end
  end
end

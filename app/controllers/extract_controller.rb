class ExtractController < ApplicationController
  def enem_digital
    filename = 'public/2021_PV_digital_D1_CD1_espanhol.pdf'
    results = ExtractQuestionsService.new(filename: filename).run
    render json: { results: results }
  end
end


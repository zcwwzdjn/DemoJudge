ActiveAdmin.register Puzzle do

  controller do
    def permitted_params
      params.permit(puzzle: [:title, :time_limit, :memory_limit, :description, :input_format, :output_format, :sample_input, :sample_output, :hint])
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :time_limit
      f.input :memory_limit
      f.input :description
      f.input :input_format
      f.input :output_format
      f.input :sample_input
      f.input :sample_output
      f.input :hint
    end
    f.actions
  end

end

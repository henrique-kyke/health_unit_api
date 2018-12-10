Exception.class_eval do
  def error
    {
      error: {
        message: message,
        full_message: 'Ocorreu algum erro inesperado.'
      }
    }
  end

  def status
    :bad_request
  end
end


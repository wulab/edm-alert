module UnsubscribesHelper
  def unsubscribe_token_verifier
    @_unsubscribe_token_verifier ||= ActiveSupport::MessageVerifier.new(
      ENV['UNSUBSCRIBE_SECRET_BASE'],
      degest: 'SHA256'.freeze
    )
  end
end

import gleam/hackney

pub type APICallError {
  NetworkError(hackney.Error)
  HTTPError(status: Int, body: String)
}

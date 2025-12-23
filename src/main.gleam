import call_llm.{call_model}
import envoy
import gleam/io
import gleam/result
import gleam/string
import serde/llm.{decode_llm_call}

const model = "openai/gpt-oss-120b"

pub fn main() {
  let key =
    envoy.get("GROQ_API_KEY")
    |> result.lazy_unwrap(fn() { panic as "ERROR: GROQ_API_KEY is not set!" })

  let url = "https://api.groq.com/openai/v1/chat/completions"
  let raw_res = call_model(url, model, key)
  let res = case raw_res {
    Ok(val) -> val
    Error(err) -> string.inspect(err)
  }
  case decode_llm_call(res) {
    Ok(res) -> io.println(string.inspect(res))
    Error(err) -> io.println(string.inspect(err))
  }
}

pub type LLMMessage {
  LLMMessage(role: String, content: String)
}

pub type LLMResponseChoice {
  LLMResponseChoice(message: LLMMessage)
}

pub type LLMResponse {
  LlmResponse(choices: List(LLMResponseChoice), created: Int)
}

pub type LLMAnswer {
  LLMAnswer(message: LLMMessage, time: Int, n_total_tokens: Int)
}

pub fn new_llm_answer(
  message: LLMMessage,
  time: Int,
  n_total_tokens: Int,
) -> LLMAnswer {
  LLMAnswer(message: message, time: time, n_total_tokens: n_total_tokens)
}

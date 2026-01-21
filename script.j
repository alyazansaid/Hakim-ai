const chat = document.getElementById("chat");
const input = document.getElementById("input");

function addMessage(text, cls) {
  const d = document.createElement("div");
  d.className = "msg " + cls;
  d.textContent = text;
  chat.appendChild(d);
  chat.scrollTop = chat.scrollHeight;
}

// استبدل 'YOUR_API_KEY_HERE' بالمفتاح حقك
const OPENAI_API_KEY = "YOUR_API_KEY_HERE";

input.addEventListener("keydown", async (e) => {
  if (e.key === "Enter" && input.value) {
    const userText = input.value;
    addMessage("أنت: " + userText, "user");
    input.value = "";

    addMessage("حكيم: ... جاري الرد", "hakim");

    try {
      const response = await fetch("https://api.openai.com/v1/chat/completions", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${OPENAI_API_KEY}`
        },
        body: JSON.stringify({
          model: "gpt-3.5-turbo",
          messages: [{ role: "user", content: userText }]
        })
      });

      const data = await response.json();
      const reply = data.choices[0].message.content;
      addMessage("حكيم: " + reply, "hakim");
    } catch (err) {
      addMessage("حكيم: حدث خطأ، تأكد من المفتاح والاتصال بالإنترنت", "hakim");
      console.error(err);
    }
  }
});

// رسالة ترحيب
addMessage("حكيم: أهلاً يا يزن! اكتب أي شيء وسأرد عليك 🤍", "hakim");
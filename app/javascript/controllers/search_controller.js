import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "suggestions"];
  connect() {}

  suggestions() {
    const query = this.inputTarget.value;
    const url = this.element.dataset.suggestionsUrl;

    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.requestSuggestions(query, url);
    }, 250);
  }

  requestSuggestions(query, url) {
    if (query.length === 0) {
      this.hideSuggestions();
      return;
    }
    this.showSuggestions();

    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']")
          .content,
      },
      body: JSON.stringify({ query: query }),
    }).then((response) => {
      response.text().then((html) => {
        document.body.insertAdjacentElement("beforeend", html);
      });
    });
  }

  showSuggestions() {
    this.suggestionsTarget.classList.remove("hidden");
  }

  hideSuggestions() {
    this.suggestionsTarget.classList.add("hidden");
  }
}

import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

// Connects to data-controller="brand-select"
export default class extends Controller {
  static targets = ['results']
  connect() {
    console.log('Brand Select Controller')
    this.timer = null;
  }

  async getBrands(query) {
    if (query.length === 0) {
      this.clearResponses()
      return
    }
    const response = await get(`/api/brands.json?query=${query}`, {
      contentType: 'application/json'
    })
    if (response.ok) {
      const body = await response.json
      return body
    }
  }

  search(event) {
    let query = event.target.value
    clearTimeout(this.timer)

    this.timer = setTimeout(async () => {
      console.log('I have now searched')
      const brands = await this.getBrands(query)
      this.appendResults(brands)
    }, 500);
  }

  appendResults(brands) {
    brands.forEach(brand => {
     this.resultsTarget.insertAdjacentHTML('beforeend', this.resultRow(brand.name))
    });
  }

  clearResponses(){
    this.resultsTarget.innerHTML = ''
  }


  resultRow(name){
    return `
      <div>
        ${name}
      </div>
      `
  }

}

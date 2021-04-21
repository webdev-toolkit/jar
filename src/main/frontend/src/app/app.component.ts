import { Component } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  
  title = '!!!... WEB DEVELOPMENT TOOLKIT ...!!!';
  greeting: any = { 'id': 'XXX', 'content': 'XXX' };

  RESOURCE_URL = '/api/resource';

  constructor(private http: HttpClient) { }

  updateDetails() {

    this.http.get(this.RESOURCE_URL).subscribe(
      data => this.greeting = data,
      err => console.log("Err ---- ", err),
      () => console.log("Update Details Complete"));
  }
}




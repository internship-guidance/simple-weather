# Simple Weather

##### Develop simple weather application for iOS, that tracks user location, updates current city, date, weather and forecasts weather for upcomming days.

### Preconditions:
- Prioritise understanding over completing;
- Ask question **only when spent at least an hour** trying to figure it out on your own, and state approaches you already took to this problem solving;
- Use [Model-View-Controller](https://medium.com/ios-os-x-development/modern-mvc-39042a9097ca) architectural pattern;
- Use latest Swift version.

### Recources:
- OpenWeatherMap API [current weather data for one location](https://openweathermap.org/current) endpoint;
- OpenWeatherMap API [16 day weather forecast](https://openweathermap.org/forecast16) endpoint;
- Apple [Core Location](https://developer.apple.com/documentation/corelocation) framework;
- [Assets](https://trello-attachments.s3.amazonaws.com/5cacdd2a6b0bdc3698b3b195/5cb5ff2c00661750a9c3bbf2/c74c9bd30ec2909a8976b660fa997ddb/assets.zip);
- (_Optional_) [Alamofire](https://github.com/Alamofire/Alamofire) library.

### Workflow:
- Create branch `develop` of `master` branch;
- Split assignment in multiple components and/or steps (_eg._ set-up environment, create user interface, implement fetching of user location, add networking layer, fetch weather data for current day, fetch weather forcaset for future days _etc._);
- For each component You will create seperate branch (_eg._ `component-x` branch), **one-at-a-time**, push changes to that branch and create pull request from `component-x` branch to `develop` branch. This way each component will be reviewed seperately inside pull request and `develop` branch will have only clean, reviewed code which will eventually build-up to complete application.

### Tips:
- You'll have to create custom `UITableViewCell` subclass and configure it when it has been dequequed;
- You'll have to create `struct` as data model, initialized from API response values.

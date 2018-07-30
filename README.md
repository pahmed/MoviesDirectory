#  Movies Directory

A demo application that allows the user to search for movies given a search query.

## Application Features

- The user can search for a movie using movie name or part of the movie name
- A user should see the search results, each result item should have movie name, movie release date, movie overview, and movie poster (if avaiable)
- A user should see the results in form of pages, i.e. when a user scrolls to the bottom, a new results page should be displayed
- A user should be able to see the recent 10 search queries on trying to make a new search

## Overall Architecture

The application follows the VIP (View - Interactor - Presenter ) pattern, this is a unidirectional data flow pattern. The implementation of this pattern is inspired by [Clean Swift](http://clean-swift.com/) based on Uncle bob [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)

![VIP](http://clean-swift.com/wp-content/uploads/2015/08/VIP-Cycle.png)

### View

A `View` is represented by a UIViewController, this is responsible for receiving user events and pass it to the interactor in a form of request to do some business logic. A `View` is also responsible for displaying the presentable view model it gets from the presenter.
A `View` can send messages (commads) **only** to the `Interactor`, and can receive mesasges **only** from the `Presenter`

### Interactor

An `Interactor` is an object, that is responsible for handling the business logic, it gets the data from a store, doing any business validation and passes the results to the `Presenter`
A `View` can send messages (data objects) **only** to the `Presenter`, and can receive mesasges **only** from the `View`

### Presenter

A `Presenter` is responsible for mapping the raw data it gets from the `Interactor` to a form of view model that can easily be displayed by the `View` without extra processing
A `Presenter` can send messages (view models) **only** to the `View`, and can receive mesasges **only** from the `Interactor`

## Project Structure

##### Models
This is a directory that contains the app model objects, usually those are just plain object for storing values

##### Utils
This direcory contains utility/helper classes

##### Constants
Application constants should be put there, it is prefered also to be grouped by its business domain

##### Networking
This contains the networking module, this module represents the networking abstraction later
- **EndpointType**
This is a protocol that defines what an endpoint should conform to
- **Endpoint**
This is a concrete `enum` implementation for `EndpointType`
Any new API should be defined as a new enum case in this file, you can have diffirent Decoders for diffierent APIs
- **API**
This represents the gateway for making any network request. 
- **Configuration**
A configuration value that defines the API configuration e.g. baseURL, apiKey, etc.

##### Store
A store represents an abstraction later for accessing any data store, weather it is through netwok, databse or memeroy
- **MovieStoreType**
A protocol the defines the requirements for being a store, this abstraction makes it easy to switch the API Store, and use another store (e.g. databse store)
- **MoviesAPIStore**
A concrete implementation for the `MovieStoreType`, it uses the `API` to make the networking calls and persist the recent search queries to the disk

##### Scenes
This directory contains the application scenes, a scene usually represents a screen. A scene is usually implemented the `VIP` archetecture. 
So, it usually consists of 4 main files `View`, `Interactor`, `Presenter`, and `Models`.
Any new scene should be in a separate directory/group

## Libraries
### [Kingfisher](https://github.com/onevcat/Kingfisher)
It is a lightweight, pure-Swift library for downloading and caching images from the web.
### [ReachabilitySwift](https://github.com/ashleymills/Reachability.swift)
A library for observing network reachability.


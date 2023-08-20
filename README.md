# Project Setup Guide

This guide explains how to set up and run the project on your local machine.

## Requirements

Before starting, make sure you have the following tools installed on your system:

- Tuist (a tool for generating Xcode projects)

## Setup

1. Install Tuist by running the following command in your terminal:

```
curl -Ls https://install.tuist.io | bash
```

2. Run `tuist fetch` command to download all the necessary dependencies used in the project.

3. Once the dependencies are downloaded, run `tuist generate` command to generate the Xcode project files.

## Running the project

After generating the Xcode project, navigate to the project directory in your terminal and open the `.xcworkspace` file then select `iRest` scheme. You can then run the project on a simulator or a physical device.


# Project Details

This project consists of a main target (App) and three different modules: DataSource, RestaurantsFeature and DesignSystem.

## App Target
This module ensures that all modules within the application communicate with each other through interfaces using the dependency library
The project utilizes the Dependencies library developed by Pointfree. Dependencies between modules have been established through this library. For example live implementation for API calls in App -> Sources -> Client+LiveImplementation

## DataSource
The DataSource module includes the following components:
- Network operations
- Interface layer for client business logic, which is either sent to the API or used within the app
- API response models
- Repositories
- NetworkManager

## DesignSystem
The DesignSystem module stores assets used in the app's design, such as fonts and images.

## RestaurantsFeature
This module includes the following views
- RestaurantsView
- DetailView
 
Each view possesses its own viewmodel that encapsulates the specific business logic for that view.
To run the tests, navigate to the RestaurantsFeature -> Tests directory and execute the tests created for each ViewModel

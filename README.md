

![DalLogo](https://github.com/user-attachments/assets/a7e5ea8c-99df-43c5-9716-3038e97222be)
---

# Dal - Local Business Advertising App



**Dal** is an innovative advertising application designed to transform the way local businesses connect with consumers. By combining targeted advertising with proximity marketing, Dal connects businesses with nearby consumers, ensuring relevance, engagement, and effective advertising.

## Key Features

- **Targeted Advertising**: Businesses can tailor their ads to specific audiences, improving engagement and conversion rates.
- **Proximity Marketing**: Ads are delivered based on the consumer's location, ensuring ads are timely and relevant.
- **User-Friendly Interface**: The intuitive design makes navigating and creating ads easy for business owners.
- **Real-Time Analytics**: Business owners can track live data on ad performance to optimize campaigns.
- **Localization Support**: Multi-language support expands reach and ensures an inclusive experience.
- **Authentication**: Includes user login, registration, and verification via `auth_cubit`.
- **Reminders & Notifications**: Keeps users updated on relevant advertisements and events.
- **Push Notifications**: Integrated with **OneSignal** for delivering timely notifications to users about new ads or important updates.
- **Map Integration**: Uses **Flutter Map** to show the user’s location and nearby businesses for effective proximity-based advertising.

Dal bridges the gap between local businesses and their customers by providing a smart advertising solution based on proximity.

## Project Structure

The Dal project is organized into logical directories for modularity and easy maintenance. Below is an overview of each folder’s purpose:

### `cubit`

- Contains **`ThemeCubit`** and **`ThemeState`** to manage the application's theme state across the app.

### `data_layer`

- **data_layer.dart**: Handles all data-related logic, serving as the intermediary between UI and data sources.

### `models`

- Defines data models representing various data structures used across the app.

### `screens`

This folder contains screen-related files, divided by feature, including authentication, profile management, and advertising functionality:

- **auth_screens**: Handles user registration, login, and verification.
  - **login_screen.dart**
  - **create_account_screen.dart**
  - **verify_screen.dart**

- **bottom_nav_bar_screen**: Manages the state of the navigation bar with BLoC architecture.

- **discover_screen**: Displays nearby businesses and ads using proximity marketing. This includes BLoC classes to handle events and states related to discovery.

- **edit_profile_screen**: Allows users to edit their profiles and manage their settings.

- **home_screen**: The landing page where users interact with different app features, including business categories.

- **onboarding_screen.dart**: Guides users through the app’s features and functionalities upon their first use.

- **reminder_screen**: Displays event or advertisement reminders to users.

- **add_ads_screen**: Allows business owners to create and add new advertisements, with state management handled by `add_ads_cubit.dart`.

- **payment_screen**: Handles payment functionality for business owners purchasing ad space.

- **profile_screen**: Allows users to manage their profile, settings, and view saved ads.

- **stats_screen**: Displays real-time analytics on ad performance for business owners.

### `services`

- **location_permission**: Manages location access, which is necessary for proximity-based advertising.
- **supabase**: Handles authentication and database interactions using Supabase.
- **onesignal**: Manages push notifications via OneSignal to send timely alerts about new ads, reminders, or updates.

### `setup`

- **setup.dart**: Configures the app with necessary setups, such as environment variables, dependency injection, and service initialization.


# ER model
---

### 1. User
- **ID** (int4): Unique identifier for each user.
- **FName** (text): First name of the user.
- **LName** (text): Last name of the user.
- **Email** (text): Email address of the user.
- **PhoneNumber** (text): Contact phone number of the user.
- **external_id** (int4): External identifier for additional integrations.
- **confirmed** (boolean): Indicates whether the user's account is confirmed.

---

### 2. Ad
- **ID** (int4): Unique identifier for each advertisement.
- **Desc** (text): Description of the advertisement.
- **StartDate** (date): Start date of the advertisement.
- **EndDate** (date): End date of the advertisement.
- **offer_type** (text): Type of offer in the advertisement (e.g., discount, promotion).
- **BannerImg** (text): URL to the banner image for the advertisement.
- **BranchID** (int4): Identifier for the branch where the ad is displayed.
- **Views** (int4): Number of times the ad has been viewed.
- **Clicks** (int4): Number of times the ad has been clicked.
- **Ended** (boolean): Indicates whether the advertisement has ended.

---

### 3. Branch
- **ID** (int4): Unique identifier for each branch.
- **Address** (text): Physical address of the branch.
- **Business_id** (int4): Identifier of the associated business.
- **longitude** (numeric): Geographical longitude of the branch.
- **latitude** (numeric): Geographical latitude of the branch.

---

### 4. Business
- **ID** (int4): Unique identifier for each business.
- **Name** (text): Name of the business.
- **Email** (text): Contact email for the business.
- **logo** (text): URL to the business logo.
- **Subscribed** (boolean): Indicates if the business is subscribed.
- **free-trial** (boolean): Indicates if the business is in a free trial period.
- **ContactNumber** (text): Contact number for the business.
- **Category** (text): Category of the business (e.g., restaurant, retail).

---

### 5. Subscription
- **ID** (int4): Unique identifier for each subscription.
- **Business_id** (int4): Identifier of the subscribed business.
- **Subscription-type** (text): Type of subscription (e.g., monthly, annual).
- **Start_date** (date): Start date of the subscription.
- **End_time** (date): End date or expiration of the subscription.

---

### Relationships:
- **User - Ad**: A user can display an ad.
- **Business - Branch**: A business can have multiple branches.
- **Business - Subscription**: A business can have one or more subscriptions.
- **Branch - Ad**: Ads are associated with specific branches.

---

![Screenshot 2024-11-07 at 12 54 40 AM](https://github.com/user-attachments/assets/01320a8a-673d-4d4e-8e7f-e771c1b72f52)

---
![Screenshot 2024-11-07 at 12 55 52 AM](https://github.com/user-attachments/assets/4ae46684-cf66-432b-bda0-87cb93f7310b)

---
## Key Dependencies

Dal uses the following dependencies to enhance functionality:

- **`flutter_bloc`**: Implements BLoC (Business Logic Component) for state management.
- **`supabase_flutter`**: Integrates Supabase for backend operations like user authentication and database management.
- **`device_preview`**: Provides an emulator to preview the app on multiple devices.
- **`lottie`**: Adds animations for a more engaging user experience.
- **`get_it`**: A service locator for dependency injection.
- **`flutter_dotenv`**: Loads environment variables, keeping API keys secure.
- **`get_storage`**: Provides a simple key-value storage solution.
- **`moyasar`**: Integrates the Moyasar payment gateway.
- **`multi_dropdown`**: Allows users to select multiple options in dropdowns.
- **`fl_chart`**: Provides beautiful charts for displaying ad performance and statistics.
- **`flutter_map`**: Adds location-based features and integrates interactive maps to display businesses near users.
- **`onesignal`**: A service for sending push notifications to engage users with relevant updates about ads or events.

Additionally, **`melos`** is used for automating tasks and managing dependencies in a large-scale Flutter project.
## Screen shot
---
#  User App

![Auth](https://github.com/user-attachments/assets/bc874e91-a22a-45aa-975f-22ea55556adb)
![Map](https://github.com/user-attachments/assets/7c3d81a1-ec3c-444c-b746-cb16c26db2ee)
![Profile](https://github.com/user-attachments/assets/4572c3a5-094b-4661-a3dc-a8c46c972431)

---
#  Business App

![Auth](https://github.com/user-attachments/assets/be97ccf0-4598-44d2-bfd7-18ee19153172)

![Subscription](https://github.com/user-attachments/assets/0a0617a2-992b-45aa-9c31-9f701edef9dd)

![Add_Ads](https://github.com/user-attachments/assets/7e8ce20f-6445-4dd7-8048-94c2ab7a7255)

![Setting](https://github.com/user-attachments/assets/56fbff14-df11-4d6c-9958-354c8fe09426)




## Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)
- Supabase credentials configured in a `.env` file
- OneSignal credentials for push notifications


## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/Nashruful/Dal
   cd dal-advertising-app
   ```

2. **Install Dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the Application:**

   ```bash
   flutter run
   ```

## Configuration

Create a `.env` file in the root directory and add your Supabase and OneSignal credentials:

```plaintext
SUPABASE_URL=https://your-supabase-url.supabase.co
SUPABASE_ANON_KEY=your-anon-key
ONESIGNAL_APP_ID=your-onesignal-app-id
```

## Contributing

We welcome contributions! If you have ideas or bug fixes, please submit a pull request.

### Steps to Contribute

1. **Fork the Repository**
2. **Create a Branch**: Work on your feature or bugfix branch.
3. **Implement Changes**: Follow the coding guidelines and document your changes.
4. **Submit a Pull Request**: Describe your changes for review.


Dal empowers local businesses to effectively advertise to consumers nearby. With its proximity-based ads, it drives community engagement and supports local economies. We’re excited to see businesses thrive using Dal!

### Team Members

- [Abdulaziz Alruwaily](https://github.com/Nashruful), [CV](https://drive.google.com/file/d/1UaIq9cQj1R-RlTdWht6RAP80j7we6o-i/edit)
- [Amjad Elahi](https://github.com/Amjad-elahi), [CV](https://flowcv.com/resume/pn6fdod6l1)
- [Linda Almakramy](https://github.com/lindamakk), [CV](https://drive.google.com/file/d/1puPpMiOlWbR8zlM9xNLXy67PdFZp_4PJ/view?usp=drive_link)
- [Nouf Alqahtani](https://github.com/noufAlqahtani1), [CV](https://drive.google.com/file/d/1V6YhwF7Uw8hKI0C0qYu4Vs7oDdhLbf6_/view?usp=drivesdk)


### Presentation

- [Dal Presentation](https://drive.google.com/file/d/1jWO89T3S-ucVFb7PijL0AunFCsNdhKtv/view?usp=sharing)

### Demo Video

- [Dal Demo](https://drive.google.com/file/d/1AWPxSIaW5-bas5-R8SKRUg-lkRJVzEUH/view?usp=sharing)

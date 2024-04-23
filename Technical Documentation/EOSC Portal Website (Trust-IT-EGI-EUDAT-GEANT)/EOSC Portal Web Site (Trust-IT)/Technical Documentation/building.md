# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## How to build

Unlike frameworks like React or Angular that necessitate a full website build before deployment, Drupal 7 offers a distinct approach. Here's the core difference:

    React/Angular: These frameworks require a complete build process, assembling all website code into a single unit for deployment.
    Drupal 7: Deployment involves assembling the website by combining pre-built components.

Imagine Drupal 7 as a construction project with pre-fabricated modules.  These modules are:

    Reusable Code Blocks (Modules): These provide functionalities like user logins, content creation tools, and more.
    Visual and Interactive Elements (Assets): This includes images, JavaScript files, stylesheets (CSS), and fonts.
    Configuration Files (Settings): Settings define website behavior like user roles, site name, and menu configurations.
    Visual Templates (Theme Templates): These dictate how the website looks, controlling layout, styling, and element display.

During deployment, there's no need to build these components. Instead, they are transferred and assembled on the server. This streamlined approach offers several advantages:

    Flexibility: Add or remove features with ease by swapping modules.
    Faster Development: Pre-built modules save development time by reducing custom coding needs.
    Scalability: As your website grows, you can seamlessly add functionalities through new modules.

In essence, deploying a Drupal 7 website is more about configuration and assembly than building from scratch. By leveraging existing, pre-built components, you can create a website tailored to your specific needs.

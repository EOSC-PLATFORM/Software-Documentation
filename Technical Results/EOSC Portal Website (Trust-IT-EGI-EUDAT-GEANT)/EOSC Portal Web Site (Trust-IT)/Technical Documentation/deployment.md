# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Deployment

Deploying a Drupal 7 website involves carefully transferring it between different environments: development, staging, and production. This ensures thorough testing before making changes live. Here's an overview of the deployment process:

## Deployment Steps:

    Development: Create and develop your Drupal website locally using tools like Drush for managing tasks.
    Database Backup and Archive: Utilize Drush to generate a database dump and compress the Drupal files (core, themes, modules) into an archive.
    Environment Transfer: Transfer the database dump and archive to the target environment (staging or production) using secure methods like SFTP.
    Database Restore: Restore the database dump onto the target environment's database server.
    File Extraction: Extract the Drupal file archive on the target environment's file system.
    Configuration: Update website configuration files like settings.php to reflect the target environment's database and server details.
    Drush Commands: Run Drush commands on the target environment to complete the deployment process. These may include installing Drupal if it's not already present and configuring the site settings.

## Required Tools and Resources:

    Drush: A powerful command-line tool for automating various Drupal tasks, including database backups, file archiving, and configuration updates during deployments.
    Version Control System (VCS): Using Git allows you to track code changes, revert to previous versions if necessary, and collaborate efficiently on website development.
    Deployment Script (Optional): Consider creating a custom script using tools like Bash or Python to automate parts of the deployment process for repeated steps or complex configurations.
    Secure File Transfer Protocol (SFTP): This secure protocol ensures the safe transfer of database dumps and website files between environments.


## Possible provider to use for the deployment
    Amazon Web Services (AWS): AWS offers a wide range of services, including EC2 instances for hosting Drupal websites.
    Google Cloud Platform (GCP): GCP provides various hosting options, including Compute Engine instances for Drupal deployments.
    Microsoft Azure: Azure offers App Service, which can be used to deploy Drupal websites easily.

On-Premise Servers:

    Dedicated Server: A dedicated server provides complete control and resources for your Drupal website.
    Virtual Private Server (VPS): A VPS offers a more cost-effective alternative to dedicated servers while still providing dedicated resources.

Kubernetes Clusters:

    Kubernetes: A container orchestration platform that enables scalable and efficient deployment of Drupal websites.

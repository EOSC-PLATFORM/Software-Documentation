# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## System Architecture

Web Server: Apache or Nginx are commonly used to serve Drupal 7 websites.

Database: MySQL, MariaDB, or PostgreSQL are popular choices for storing Drupal data.

File System: Stores Drupal core files, themes, modules, and uploaded content.

PHP: The server-side scripting language that powers Drupal.

Drush: A command-line tool for automating Drupal tasks.

Composer: A dependency manager for PHP applications.

## Deployment Process:

    Use Drush to create a database dump and archive the Drupal files.
    Transfer the database dump and Drupal files to the production server.
    Restore the database dump on the production server.
    Extract the Drupal files on the production server.
    Configure the web server and database settings.
    Run Drush to install Drupal and configure the site.


## Components, modules, and their interactions.
    No custom modules developed
	All the modules used are supported by the Drupal 7 community

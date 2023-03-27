# pd_app

Digital Patient Directive

## Content Management System

Dynamic content is managed using Strapi as Content Management System.

### Current dynamic content

Dynamic content is currently managed at https://strapi.dpv.staging.deyan7.de/admin

Content is saved as asset files in /assets/cms. Asset files can be updated by running cms_asset_generator.dart. You need
to
specify the environment variable `CMS_API_TOKEN`.

Content will not be updated at runtime at this moment.

Dynamic content comprises:

- Examples of positive aspects
- Examples of negatives aspects
- Examples of future situations

### Planned dynamic content

- Entry and outro test of every page as markdown
- Context help regarding every page
- Onboarding pages
- Text content of generated pdf

## Coding style

We prefer `Clean Code` as defined by Robert C. Martin.

Most of the style is secured by Linters and Analyzers, config can be found in `analysis_options.yaml`.  
**Line Length** of the project is **120** characters. This can be adjusted in your favorite IDE of choice.  
We also recommend to automatically run **formatting on file save**, which most IDEs are capable of.

## Branching Model

We use `Feature Branching` (https://www.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow).

## Architectural Pattern

We want to use `MVVM` (Model-View-ViewMode).

## Development Process

- Development Language: _English_
- We open Merge Requests for code changes
- We let another developer review our code
- We need one approval from another developer to merge our code into the main line
- The author merges his MR after approval
- Every requirement, improvement or bug is added as an issue to Gitlab issues
- These issue focus on value for the end customer. Their title should have meaning to our stakeholders.
- Software bugs should be reproduced using an automated unit or widget tests, then fixed. Exceptions are possible if
  cost/benefit ratio is bad.
- Requirements and improvements should be tested using automated unit or widget tests. It is a good practice to
  implement the tests first.
- If an issue is to hard to test, and cost/benefit ratio seems bad, this should be documented within the merge request.

## Definition of Done

- There are sufficient tests to verify requirements are met, bugs are detected and regressions prevented
- Continuous Integration was successful, i.e. the app can be built, there are no code quality issues and all unit and
  widget tests are successful
- Error messages and hints are static, i.e. don't use information created at runtime by errors or transmitted from
  servers or bluetooth devices. (this helps to prevent the exposure of confidential information to the user)
- Acceptance criteria are met

# Development Know How

## Regenerating generated code

When changing or adding to services, or adapting serializable models, it might be necessary to regenerate mocks. This
can be done using the
command `flutter pub run build_runner build`

## Fetching content from Strapi

[Strapi Admin Login](https://strapi.dpv.staging.deyan7.de/admin/)
When running cms_asset_generator (with ENV variable CMS_API_TOKEN=API_TOKEN_GOES_HERE_AND_CAN_BE_FOUND_IN_PASSWORD_VAULT) the content from Strapi is downloaded and created as asset files.
The token is in getIt right now too - it's a read only token for the system. In the long run and for more load, you might want to put an Http cache in front of Strapi anyway, which can then also hide the API token.
The output is searched for media urls, and these are also created as assets.
The content is accessed in the app via the ContentService. This loads the content into memory.
After the local assets are loaded, the view is built and then the CMS content is updated live.

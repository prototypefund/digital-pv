# pd_app

Digital Patient Directive

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
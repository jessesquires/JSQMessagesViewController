# Contributor Onboarding

*Contributor onboarding guide for JSQMessagesViewController*

This guide is intended to bring new core contributors up-to-speed on the project, organization, expectations, and best practices.

-------------------------

## Introduction

Welcome! :smile: If you are reading this, then you are (or are about to be) a core contributor! :tada: The goal of this document is to cover everything you need to know about helping to maintain this project. If you are not familiar with the code, the docs, the demo project, and everything else in the repo, then that should be your first step. Otherwise, continue on!

## Getting push access

Being a **contributor** means submitting pull requests, opening issues, etc. Being a **core contributor** means getting push access and other permissions.

We love freely giving push access to great contributors, and always err on trusting contributors with this responsibility. However, before granting you push access we would like to see a few things:

- An interest and dedication to the project
- Helping to triage issues, review pull requests, and diagnose bugs
- Submitting a couple great pull requests

We really prefer to grant push access to contributors who have a decent amount of time to share each week or month. If you cannot be extremely active on the project — that's ok! You can still be an :sparkles: awesome contributor :sparkles: without getting push access! 

The rationale behind all of this is that we do not want to accumulate a *huge* list of **core contributors** that are *not* regularly active.

Remember, *your time* is *your time* — there is absolutely no pressure on you to spend a lot of time on this project, although it is greatly appreciated! :smile:

> **Note:** the rest of this document applies to both **contributors** and **core contributors**, but there are some details that would require having push access.

## Core team

### Project lead

Jesse Squires ([**@jessesquires**](https://github.com/jessesquires)) serves as the lead for `JSQMessagesViewController`.

Responsibilities include:
- Managing releases and CocoaPods distributions
- Merging code into `master`
- Overall guidance on design, architecture, and implementation
- Strategic direction for the library
- Onboarding new core contributors
- Everything under **Core Contributors** :smile:
- Anything not covered by **Core Contributors** :smile:

As core contributors grow and take on more repsonsibility, they can become a lead.

### Core contributors

Core contributors have push access and are responsible for:

- Bug fixes
- New features
- Triaging issues (managing, organizing)
- Reviewing pull requests
- Answering questions from the community on [issues](https://github.com/jessesquires/JSQMessagesViewController/issues?utf8=✓&q=is%3Aissue+label%3A%22questions+%26+help%22+) and [StackOverflow](http://stackoverflow.com/questions/tagged/jsqmessagesviewcontroller)
- Documentation

Current core contributors:
- Harlan Haskans ([**@harlanhaskins**](https://github.com/harlanhaskins))

## Pushing code

Although you have permissions to push code directly to `develop` as a core contributor, we ask that you *always* submit a pull request for code changes. After a code review and approval, you may merge your diff. For minor changes, like formatting or typos, pushing directly to `develop` is acceptable. 

Always merge work to `develop` unless otherwise specified. The project lead will manage the `master` branch.

For now, Jesse ([**@jessesquires**](https://github.com/jessesquires)) should provide the final approval for *all* pull requests. However, as core contributors grow and establish themselves in the project, they can take on this responsibility as well.

## Project managment

### General guidelines

Above all, abide by our [code of conduct](https://github.com/jessesquires/JSQMessagesViewController/blob/develop/.github/CONDUCT.md) at all times. Be welcoming, kind, and inclusive.

Often, users do not follow our [contributing guidelines](https://github.com/jessesquires/JSQMessagesViewController/blob/develop/.github/CONTRIBUTING.md), fail to complete the [issue template](https://github.com/jessesquires/JSQMessagesViewController/blob/develop/.github/ISSUE_TEMPLATE.md), or fail to complete the [pull request template](https://github.com/jessesquires/JSQMessagesViewController/blob/develop/.github/PULL_REQUEST_TEMPLATE.md). This is frustrating, but the best response is to kindly remind and encourage them to follow the correct procedures next time.

When first responding to a newly opened issue or pull request, *always* thank the contributor and add some sweet emoji. Any positive emoji will work. (:+1:, :smile:, :sunglasses:, etc.) Choose your favorite.

> Thanks **@jessesquires**! :smile_cat:

Then continue on with the rest of your comment. There will be times where we simply cannot accept a patch for various reasons. In this case, kindly explain why it is not the right approach for the library, thank them for their time and effort, and encourage them to keep contributing.

In any situation, when in doubt, tag the project lead in a comment to get feedback.

### Development

- All work for minor and patch releases should happen on `develop`. For example, release 7.x.x.
- All work for major releases should happen on a release branch. For example, `release_8.0`.
- The project lead will manage the `master` branch.

For core contributors, always assign issues or pull requests to the appropriate team member. If you are working on an issue, assign it to yourself. If you would like someone to review a pull request, assign it to them.

### Managing issues

- Always add the appropriate label(s). There may be more than one.
- Assign to a release milestone, if applicable.
- Ask for more information from the user, if needed.
- Verify bugs. Leave comments on your findings as necessary.
- If it's a duplicate, label and close.
- Follow the general guidelines above.

##### Special labels

- [`needs review`](https://github.com/jessesquires/JSQMessagesViewController/issues?q=is%3Aissue+label%3A%22needs+review%22): These issues need to be triaged and confirmed. They are typically bugs or pull requests, but do not have to be. Once verified, `needs review` should be removed and any other appropriate labels should be added.
- [`new release roadmap`](https://github.com/jessesquires/JSQMessagesViewController/issues?utf8=✓&q=is%3Aissue+label%3A%22new+release+roadmap%22+): For communicating new releases to the community.
- [`in-progress`](https://github.com/jessesquires/JSQMessagesViewController/issues?q=is%3Aissue+label%3Ain-progress): Specifies a task that is currently being worked on. Remove this label after closing a task.
- [`duplicate`](https://github.com/jessesquires/JSQMessagesViewController/issues?utf8=✓&q=label%3Aduplicate+): For duplicate isses. When closing an issue as a duplicate be sure to leave a comment with the original issue number. *"Closing as duplicate of #6."*
- [`questions & help`](https://github.com/jessesquires/JSQMessagesViewController/issues?q=is%3Aissue+label%3A%22questions+%26+help%22): For community questions and help. Note that we are trying to refer questions to [StackOverflow](http://stackoverflow.com/questions/tagged/jsqmessagesviewcontroller) instead.

### Managing pull requests

- Review the code for correctness, performance, style, etc. Leave comments as needed.
- Always add the appropriate label(s). There may be more than one.
- Assign to a release milestone, if applicable.
- Follow the general guidelines above.
- If you think it's ready to go, tag the project lead to get the final :+1:

### Managing releases

All releases are organized using [milestones](https://github.com/jessesquires/JSQMessagesViewController/milestones). Use these to prioritize work and figure out what's next.

Issues and pull requests included in the next milestone release should be the highest priorty. Once a milestone is 100% complete, the project lead will merge `develop` or other release branches into `master`. The project lead will close the milestone, tag the release, and submit to CocoaPods.

### Managing documentation

Having high quality documentation and 100% coverage has a significant impact on the project's success. 

Always add new docs for new public APIs and keep them up-to-date. Use existing docs and Apple's docs for Cocoa as guidelines for writing great documentation.

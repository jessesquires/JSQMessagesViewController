# CHANGELOG

The changelog for `JSQMessagesViewController`. Also see the [releases](https://github.com/jessesquires/JSQMessagesViewController/releases) on GitHub.

--------------------------------------

8.0.0
-----

This release closes the [8.0.0 milestone](https://github.com/jessesquires/JSQMessagesViewController/milestones/8.0.0).

### Breaking changes

- Removed `JSQSystemSoundPlayer` as a dependency, see #1649 for reasoning. You can easily still include this in your project by adding `pod 'JSQSystemSoundPlayer'` to your Podfile. You can find out the latest on `JSQSystemSoundPlayer` [here](https://github.com/jessesquires/JSQSystemSoundPlayer).
- Removed `JSQMessagesKeyboardController` and implemented a proper `inputAccessoryView`. (#1063, #1529) Thanks @LeoNatan and @kirualex!
- `JSQMessagesToolbarButtonFactory` is now an instance, not just class methods. (#1651, #866) Thanks @burntheroad!
- `JSQMessagesAvatarImageFactory` is now an instance, not just class methods. (#1659, #1657) Thanks @burntheroad!
- `JSQMessagesInputToolbar` now provides more control over the placement of the send button. (#840) Thanks @davidchiles!

### Enhancements

- Better Swift inter-op. Implemented Objective-C nullability. (#1654) Thanks @Lucashuang0802!
- Animated typing indicator. Typing indicator now animates like iMessage. (#1382) Thanks @radekcieciwa!
- Dynamic text support. (#497, #1747) Thanks @MacMeDan!
- Message cells now have a customizable accessory view. (#1519, #1719) Thanks @adubr!
- Send button now can be turned on/off manually. (#1575 #1609) Thanks @sebastianludwig!

### Fixes

- Fixed a number of issues regarding keyboard handling. Keyboard handling is now much more stable. (#1063, #1529, #799, #941, #1299, #558, #557)
- Fixed potential crash with media cells. (#1377, #1741) Thanks @Lucashuang0802!

7.3.4
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A7.3.4+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/7.3.4)

7.3.3
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A7.3.3+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/7.3.3)

7.3.2
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A7.3.2+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/7.3.2)

7.3.1
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A7.3.1+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/7.3.1)

7.3.0
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A7.3.0+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/7.3.0)


7.2.0
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A7.2.0+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/7.2.0)

7.1.0
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A7.1.0+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/7.1.0)

7.0.2
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A7.0.2+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/7.0.2)

7.0.1
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A7.0.1+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/7.0.1)

7.0.0
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A7.0.0+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/7.0.0)

6.1.3
-----

- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/6.1.3)

6.1.2
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A6.1.2+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/6.1.2)

6.1.1
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A6.1.1+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/6.1.1)

6.0.0
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A6.0.0+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/6.0.0)

5.3.0
-----

- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/5.3.0)

5.2.0
-----

- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/5.2.0)

5.1.0
-----

- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/5.1.0)

5.0.3
-----

- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/5.0.3)

5.0.0
-----

- [Milestone](https://github.com/jessesquires/JSQMessagesViewController/issues?q=milestone%3A5.0.0+is%3Aclosed)
- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/5.0.0)

4.0.0
-----

- [GitHub release notes](https://github.com/jessesquires/JSQMessagesViewController/releases/tag/4.0.0)

All previous versions
---------------------

Unfortunately, release notes are not available for earlier versions of the library.

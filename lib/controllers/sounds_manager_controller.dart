import 'package:audioplayers/audioplayers.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class SoundsManagerController extends GetxController {
  /* *************** Variables *************** */
  final box = GetStorage();

  /// get Tally Sound mode
  bool get isTallySoundAllowed => box.read('tally_sound') ?? false;

  /// set Tally Sound mode
  void changeTallySoundStatus(bool val) => box.write('tally_sound', val);

  /// get Tally Sound mode
  bool get isZikrDoneSoundAllowed => box.read('zikr_done_sound') ?? false;

  /// set Tally Sound mode
  void changeZikrDoneSoundStatus(bool val) => box.write('zikr_done_sound', val);

  /// get Tally Sound mode
  bool get isTransitionSoundAllowed =>
      box.read('tally_transition_sound') ?? false;

  /// set Tally Sound mode
  void changeTransitionSoundStatus(bool val) =>
      box.write('tally_transition_sound', val);

  /// get Tally Sound mode
  bool get isAllAzkarFinishedSoundAllowed =>
      box.read('all_azkar_finished_sound') ?? false;

  /// set Tally Sound mode
  void changeAllAzkarFinishedSoundStatus(bool val) =>
      box.write('all_azkar_finished_sound', val);

  ///
  final player = AudioCache();
/* *************** Controller life cycle *************** */

  /* *************** Functions *************** */
  //
  playTallySound() {
    if (isTallySoundAllowed) {
      player.play('sounds/tally_sound.mp3');
    }
  }

  playZikrDoneSound() {
    if (isZikrDoneSoundAllowed) {
      player.play('sounds/zikr_done_sound.mp3');
    }
  }

  playTransitionSound() {
    if (isTransitionSoundAllowed) {}
  }

  playAllAzkarFinishedSound() {
    if (isAllAzkarFinishedSoundAllowed) {
      player.play('sounds/all_azkar_finished_sound.mp3');
    }
  }
}

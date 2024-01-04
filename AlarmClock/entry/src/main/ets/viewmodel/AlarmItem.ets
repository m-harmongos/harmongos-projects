import { WeekDays } from '../common/CommonConstants';
import ReminderItem from '../model/ReminderItem';

@Observed export default class AlarmItem extends ReminderItem {
  name = '闹钟';
  isOpen: boolean = true;
  isRepeat: boolean = false;
  duration: number = 5;
  intervalMinute: number = 10;
  intervalTimes:number = 3;
}
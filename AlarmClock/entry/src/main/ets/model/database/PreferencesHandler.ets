import data_preferences from '@ohos.data.preferences';
import { CommonConstants } from '../../common/CommonConstants';
import PreferencesListener from './PreferencesListener';

export default class PreferencesHandler {
  // 单例
  static instance: PreferencesHandler = new PreferencesHandler();
  // 首选项存储
  private preferences: data_preferences.Preferences | null = null;
  private defaultValue = '';
  // 数据监听列表
  private listeners: PreferencesListener[];

  constructor() {
    this.listeners = new Array<PreferencesListener>();
  }

  public async configure(context: Context) {
    // 初始化首选项，只能在内存中使用
    this.preferences = await data_preferences.getPreferences(context, CommonConstants.PREFERENCE_ID);
    // 监听数据改变
    this.preferences.on('change', (data: Record<string, Object>) => {
      for (let preferencesListener of this.listeners) {
        preferencesListener.onDataChanged(data.key as string);
      }
    });
  }

  public async set(key: string, value: string) {
    if (this.preferences) {
      await this.preferences.put(key, value);
      await this.preferences.flush();
    }
  }

  public async get(key: string) {
    let data = '';
    if (this.preferences) {
      data = await this.preferences.get(key, this.defaultValue) as string;
    }
    return data;
  }

  public clear() {
    if (this.preferences) {
      this.preferences.clear()
    }
  }

  public addPreferencesListener(listener: PreferencesListener) {
    this.listeners.push(listener);
  }
}
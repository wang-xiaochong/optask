import { allIcons, getIcons } from '@/utils/icons';
import { Dropdown, MenuProps } from 'antd';
import { MenuInfo } from 'rc-menu/lib/interface';

export const TaskOptionsDropdown = () => {
  const items: MenuProps['items'] = [
    {
      key: '1',
      label: '项目',
    },
    {
      key: '2',
      label: '工作包',
    },
    // {
    //   key: '3',
    //   label: '3rd menu item',
    // },
  ];
  const onMenuClick = (event: MenuInfo) => {
    const { key } = event;
    console.log(key);
    switch (key) {
      case '1':
        break;
      case '2':
        break;

      default:
        break;
    }
  };
  return (
    <>
      <div
        style={{
          display: 'flex',
          // height: 26,
        }}
      >
        <Dropdown
          menu={{
            selectedKeys: [],
            onClick: onMenuClick,
            items: items,
          }}
          placement="bottom"
        >
          {getIcons(allIcons.TaskOptions)}
        </Dropdown>
      </div>
    </>
  );
};

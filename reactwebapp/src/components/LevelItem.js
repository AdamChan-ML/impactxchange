import React from 'react';

function LevelItem({ level, onClick }) {
  return (
    <li onClick={() => onClick(level.id)}>
      {level.title}
    </li>
  );
}

export default LevelItem;

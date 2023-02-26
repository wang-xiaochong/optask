// import BraftEditor from 'braft-editor';
// import 'braft-editor/dist/index.css';
// import PropTypes from 'prop-types';
// import React from 'react';
// import styles from './index.less';

// export default class BasicDemo extends React.Component {
//   static propTypes = {
//     // uploadUrl: PropTypes.string,
//     onChange: PropTypes.func,
//     echoData: PropTypes.string,
//   };

//   static defaultProps = {
//     onChange() {},
//   };

//   state = {
//     editorState: BraftEditor.createEditorState(''),
//   };

//   componentDidMount() {
//     this.isLivinig = true;
//     this.setState({
//       editorState: BraftEditor.createEditorState(
//         this.props.echoData ? this.props.echoData : '<p></p>',
//       ),
//     });
//   }

//   componentWillUnmount() {
//     this.isLivinig = false;
//   }

//   handleChange = (editorState) => {
//     this.setState({
//       editorState: editorState,
//     });

//     // 因为要做必填校验,默认的是会有一对p标签,所以封装的时候直接就给过滤掉

//     this.props.onChange(editorState.toHTML() !== '<p></p>' ? editorState.toHTML() : '');
//   };

//   // 异步数据回填

//   setEditorContentAsync = () => {
//     if (this.isLivinig) {
//       this.setState({
//         editorState: BraftEditor.createEditorState('我是显示的内容'),
//       });
//     }
//     return null;
//   };

//   render() {
//     const { editorState } = this.state;
//     return (
//       <div className={styles.richText}>
//         <div className="editor-wrapper">
//           <BraftEditor
//             contentClassName={styles.contentStyle}
//             value={editorState}
//             placeholder="请输入"
//             onChange={this.handleChange}
//           />
//         </div>
//       </div>
//     );
//   }
// }

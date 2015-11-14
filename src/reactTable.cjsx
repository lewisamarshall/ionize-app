# coffeelint: disable=max_line_length
React = require('react')
ReactDOM = require('react-dom')
Typeahead = require('react-typeahead').Typeahead
db = require('./bin/utils').db
options = [name for name of db][0]
options.sort()

SolutionTable = React.createClass
  getInitialState: ->
    data: [
      {ion: 'tris', concentration: 0.01},
      {ion: 'hydrochloric acid', concentration: 0.005}
    ]
    columns: ['ion', 'concentration']

  render: ->
    <table className="solution-table" border="1">
      <TableHeader columns={@state.columns}/>
      <tbody>
        {for rowdata, i in @state.data
          <TableRow onRemove={@removeRow}
                    data={rowdata}
                    columns={@state.columns}
                    index={i}
                    key={i} />
        }
      <tr> <td> <AddButton handleClick={@addRow}/> </td> </tr>
      </tbody>
    </table>

  addRow: ->
    newData = @state.data.concat {ion: 'tris', concentration: 0.01}
    @setState(
      data: newData
      )

  removeRow: (id)->
    newData = (row for row, i in @state.data when i isnt id)
    @setState(
      data: newData
      )

TableRow = React.createClass
  render: ->
    <tr>
      <td><RemoveButton rowId={@props.index} handleClick={@props.onRemove}/></td>
      {for column, i in @props.columns
        <td key={i}>{@props.data[column]}</td>
      }
      <td><Typeahead options={options} maxVisible={5}/></td>
    </tr>

TableHeader = React.createClass
  render: ->
    <thead>
    <tr>
      <th></th>
      {for column, i in @props.columns
        <th key={i}>{column}</th>
      }
    </tr>
    </thead>

RemoveButton = React.createClass
  render: ->
    <button onClick={@clickHandler}>Remove</button>

  clickHandler: ->
    @props.handleClick(@props.rowId)

AddButton = React.createClass
  render: ->
    <button onClick={@props.handleClick}>Add</button>

IonSelector = React.createClass
  render: ->
    <select value={@props.value} onChange={@handleChange}>
      {for option, i in @props.options
        <option key={i} value={option}>{option}</option>
      }
    </select>

  handleChange: (event) ->
    value = event.target.value
    if @props.changeHandler?
      @props.changeHandler(value)
    else
      console.log(value)

ReactDOM.render(<SolutionTable/>, document.getElementById('content'))
